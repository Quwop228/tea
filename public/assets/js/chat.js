
(function () {
    'use strict';

    var doc = document;

    var modal       = doc.getElementById('chatModal');
    var fab         = doc.getElementById('chatFab');
    var banner      = doc.getElementById('assistantBanner');
    var closeBtn    = doc.getElementById('chatClose');
    var body        = doc.getElementById('chatBody');
    var greeting    = doc.getElementById('chatGreeting');
    var messages    = doc.getElementById('chatMessages');
    var input       = doc.getElementById('chatInput');
    var sendBtn     = doc.getElementById('chatSend');
    var suggestions = doc.getElementById('chatSuggestions');
    var scrollDown  = doc.getElementById('chatScrollDown');
    var cartBadge   = doc.getElementById('cartBadge');

    if (!modal || !input) {
        return;
    }

    var MAX_LEN = 500;
    var cart = {};
    var hasStarted = false;
    var pending = false;

    function isMobile() {
        return window.matchMedia('(max-width: 760px)').matches;
    }

    function openModal() {
        modal.classList.add('is-open');
        modal.setAttribute('aria-hidden', 'false');
        doc.body.classList.add('is-chat-open');

        window.setTimeout(function () { input.focus(); }, 50);
    }

    function closeModal() {
        modal.classList.remove('is-open');
        modal.setAttribute('aria-hidden', 'true');
        doc.body.classList.remove('is-chat-open');
    }

    var openers = doc.querySelectorAll('[data-open-chat]');
    for (var i = 0; i < openers.length; i++) {
        openers[i].addEventListener('click', openModal);

        openers[i].addEventListener('keydown', function (e) {
            if (e.key === 'Enter' || e.key === ' ' || e.key === 'Spacebar') {
                e.preventDefault();
                openModal();
            }
        });
    }

    if (closeBtn) {
        closeBtn.addEventListener('click', closeModal);
    }

    doc.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && modal.classList.contains('is-open')) {
            closeModal();
        }
    });

    if (fab && banner) {
        if ('IntersectionObserver' in window) {
            var io = new IntersectionObserver(function (entries) {
                fab.classList.toggle('is-visible', !entries[0].isIntersecting);
            }, { threshold: 0 });
            io.observe(banner);
        } else {
            window.addEventListener('scroll', function () {
                var rect = banner.getBoundingClientRect();
                fab.classList.toggle('is-visible', rect.bottom < 0);
            });
        }
    }

    (function () {
        var track = doc.getElementById('bannerTrack');
        var dotsBox = doc.getElementById('bannerDots');
        if (!track || !dotsBox) return;

        var slides = track.querySelectorAll('.banner__slide');
        var dots = dotsBox.querySelectorAll('button');
        if (slides.length < 2) return;

        var idx = 0;

        function move(n) {
            idx = (n + slides.length) % slides.length;
            var slideW = slides[0].getBoundingClientRect().width;
            var sliderW = track.parentElement.getBoundingClientRect().width;
            var GAP = parseFloat(getComputedStyle(track).gap) || 16;
            var EDGE = parseFloat(getComputedStyle(track.parentElement).getPropertyValue('--slider-edge')) || 0;
            var step = slideW + GAP;
            var x;
            if (idx === slides.length - 1) {
                x = sliderW - EDGE - (slides.length * slideW + (slides.length - 1) * GAP);
            } else if (idx === 0) {
                x = EDGE;
            } else {
                x = -idx * step + EDGE;
            }
            track.style.transform = 'translateX(' + x + 'px)';
            for (var d = 0; d < dots.length; d++) {
                dots[d].classList.toggle('is-active', d === idx);
            }
        }

        for (var d = 0; d < dots.length; d++) {
            (function (n) {
                dots[n].addEventListener('click', function () { move(n); });
            })(d);
        }

        window.addEventListener('resize', function () { move(idx); });

        var slider = track.parentElement;
        var startX = null;
        var swiped = false;
        slider.addEventListener('pointerdown', function (e) {
            startX = e.clientX;
            swiped = false;
        });
        slider.addEventListener('pointermove', function (e) {
            if (startX !== null && Math.abs(e.clientX - startX) > 10) {
                swiped = true;
            }
        });
        slider.addEventListener('pointerup', function (e) {
            if (startX === null) { return; }
            var dx = e.clientX - startX;
            if (Math.abs(dx) > 40) {
                move(dx < 0 ? idx + 1 : idx - 1);
            }
            startX = null;
        });
        slider.addEventListener('pointercancel', function () { startX = null; });

        slider.addEventListener('click', function (e) {
            if (swiped) {
                e.stopPropagation();
                e.preventDefault();
                swiped = false;
            }
        }, true);

        move(0);
    })();

    function autoSize() {
        input.style.height = 'auto';
        input.style.height = input.scrollHeight + 'px';
    }

    function refreshSendState() {
        sendBtn.disabled = input.value.trim() === '' || pending;
    }

    input.addEventListener('input', function () {
        if (input.value.length > MAX_LEN) {
            input.value = input.value.slice(0, MAX_LEN);
        }
        autoSize();
        refreshSendState();
    });

    input.addEventListener('keydown', function (e) {

        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            submit(input.value);
        }
    });

    sendBtn.addEventListener('click', function () {
        submit(input.value);
    });

    refreshSendState();

    if (suggestions) {
        var chips = suggestions.querySelectorAll('.chip');
        for (var c = 0; c < chips.length; c++) {
            chips[c].addEventListener('click', function () {
                submit(this.textContent.trim());
            });
        }

        var dotsBox = doc.getElementById('chatSuggestionsDots');
        if (dotsBox) {
            var dotEls = [];
            function rebuildDots() {
                var pages = Math.max(1, Math.ceil(suggestions.scrollWidth / suggestions.clientWidth));
                if (pages === dotEls.length) { return; }
                dotsBox.innerHTML = '';
                dotEls = [];
                for (var k = 0; k < pages; k++) {
                    var s = doc.createElement('span');
                    if (k === 0) { s.className = 'is-active'; }
                    dotsBox.appendChild(s);
                    dotEls.push(s);
                }
            }
            function refreshActive() {
                if (!dotEls.length) { return; }
                var page = Math.round(suggestions.scrollLeft / Math.max(1, suggestions.clientWidth));
                if (page >= dotEls.length) { page = dotEls.length - 1; }
                for (var k = 0; k < dotEls.length; k++) {
                    dotEls[k].classList.toggle('is-active', k === page);
                }
            }
            rebuildDots();
            suggestions.addEventListener('scroll', refreshActive, { passive: true });
            window.addEventListener('resize', function () { rebuildDots(); refreshActive(); });
        }
    }

    function submit(text) {
        text = (text || '').trim();
        if (text === '' || pending) {
            return;
        }

        if (!hasStarted) {
            hasStarted = true;
            modal.classList.add('is-started');
            if (greeting) { greeting.classList.add('is-hidden'); }

        }

        appendUserMessage(text);

        input.value = '';
        autoSize();

        var loader = appendLoader();
        pending = true;
        refreshSendState();

        var data = new FormData();
        data.append('query', text);

        fetch('api/chat.php', { method: 'POST', body: data })
            .then(function (res) { return res.json(); })
            .then(function (payload) {
                loader.remove();
                renderResponse(payload);
            })
            .catch(function () {
                loader.remove();
                renderResponse({
                    type: 'text',
                    content: 'Произошла ошибка соединения. Попробуйте ещё раз. 🍵'
                });
            })
            .then(function () {
                pending = false;
                refreshSendState();
            });
    }

    function appendUserMessage(text) {
        var msg = ce('div', 'msg msg--user');
        var bubble = ce('div', 'msg__bubble');
        bubble.textContent = text;
        msg.appendChild(bubble);
        messages.appendChild(msg);
        scrollToBottom();
        return msg;
    }

    function appendLoader() {
        var msg = ce('div', 'msg msg--bot');
        var loader = ce('div', 'msg__loader');
        for (var d = 0; d < 3; d++) {
            loader.appendChild(ce('span', 'dot'));
        }
        var label = ce('span');
        label.textContent = 'Думаю и скоро отвечу…';
        loader.appendChild(label);
        msg.appendChild(loader);
        messages.appendChild(msg);
        scrollToBottom();
        return msg;
    }

    function renderResponse(payload) {
        var firstEl;

        if (payload && payload.type === 'products' && payload.products && payload.products.length) {
            firstEl = appendBotText('Вот что я могу предложить:');
            messages.appendChild(buildProductList(payload.products));
        } else if (payload && payload.type === 'text') {
            firstEl = appendBotText(payload.content || '');
        } else {
            firstEl = appendBotText('К сожалению, я ничего не нашёл. Попробуйте переформулировать запрос. 🍵');
        }

        revealAnswer(firstEl);
    }

    function appendBotText(text) {
        var msg = ce('div', 'msg msg--bot');
        var bubble = ce('div', 'msg__bubble');
        bubble.textContent = text;
        msg.appendChild(bubble);
        messages.appendChild(msg);
        return msg;
    }

    function buildProductList(products) {
        var list = ce('div', 'product-list');
        for (var p = 0; p < products.length; p++) {
            list.appendChild(buildProductCard(products[p]));
        }
        return list;
    }

    function buildProductCard(product) {
        var card = ce('div', 'product-card');

        var fav = ce('button', 'product-card__fav');
        fav.type = 'button';
        fav.setAttribute('aria-label', 'В избранное');
        fav.addEventListener('click', function () {
            fav.classList.toggle('is-active');
        });
        card.appendChild(fav);

        var main = ce('div', 'product-card__main');

        var imgWrap = ce('div', 'product-card__img-wrap');
        var img = ce('img', 'product-card__img');
        img.src = product.image || '';
        img.alt = product.name || '';
        img.loading = 'lazy';
        img.addEventListener('error', function () {
            var fallback = ce('div', 'product-card__img product-card__img--fallback');
            fallback.textContent = product.emoji || '🍵';
            if (img.parentNode) {
                img.parentNode.replaceChild(fallback, img);
            }
        });
        imgWrap.appendChild(img);
        main.appendChild(imgWrap);

        var bodyEl = ce('div', 'product-card__body');
        var name = ce('h3', 'product-card__name');
        name.textContent = product.name || '';
        bodyEl.appendChild(name);
        var desc = ce('p', 'product-card__desc');
        desc.textContent = product.description || '';
        bodyEl.appendChild(desc);
        main.appendChild(bodyEl);

        card.appendChild(main);

        var foot = ce('div', 'product-card__foot');

        var actions = ce('div', 'product-card__actions');
        var addBtn = ce('button', 'btn-add');
        addBtn.type = 'button';
        addBtn.textContent = 'Добавить';
        addBtn.addEventListener('click', function () {
            startQuantity(product, addBtn, actions);
        });
        actions.appendChild(addBtn);

        var weight = ce('select', 'product-card__weight');
        weight.setAttribute('aria-label', 'Граммовка');
        ['50', '100', '150'].forEach(function (g) {
            var opt = doc.createElement('option');
            opt.value = g;
            opt.textContent = g + 'гр.';
            weight.appendChild(opt);
        });
        actions.appendChild(weight);

        var more = ce('button', 'btn-ghost');
        more.type = 'button';
        more.textContent = 'О чае';
        actions.appendChild(more);

        foot.appendChild(actions);

        var price = ce('div', 'product-card__price');
        price.textContent = product.price || '';
        foot.appendChild(price);

        card.appendChild(foot);
        return card;
    }

    function startQuantity(product, addBtn, actions) {
        var qty = ce('div', 'qty');

        var dec = ce('button', 'qty__btn qty__btn--minus');
        dec.type = 'button';
        dec.setAttribute('aria-label', 'Убавить');

        var value = ce('span', 'qty__value');
        value.textContent = '1';

        var inc = ce('button', 'qty__btn qty__btn--plus');
        inc.type = 'button';
        inc.setAttribute('aria-label', 'Добавить');

        qty.appendChild(dec);
        qty.appendChild(value);
        qty.appendChild(inc);

        actions.replaceChild(qty, addBtn);
        setCart(product.id, 1);

        inc.addEventListener('click', function () {
            var n = parseInt(value.textContent, 10) + 1;
            value.textContent = String(n);
            setCart(product.id, n);
        });

        dec.addEventListener('click', function () {
            var n = parseInt(value.textContent, 10) - 1;
            if (n <= 0) {
                actions.replaceChild(addBtn, qty);
                setCart(product.id, 0);
            } else {
                value.textContent = String(n);
                setCart(product.id, n);
            }
        });
    }

    function setCart(id, quantity) {
        if (quantity > 0) {
            cart[id] = quantity;
        } else {
            delete cart[id];
        }
        updateCartBadge();
    }

    function updateCartBadge() {
        if (!cartBadge) { return; }
        var total = 0;
        for (var key in cart) {
            if (Object.prototype.hasOwnProperty.call(cart, key)) {
                total += cart[key];
            }
        }
        cartBadge.textContent = String(total);
        if (total > 0) {
            cartBadge.removeAttribute('hidden');
        } else {
            cartBadge.setAttribute('hidden', '');
        }
    }

    function scrollToBottom() {
        body.scrollTop = body.scrollHeight;
    }

    function revealAnswer(firstEl) {
        if (isMobile() && firstEl) {
            var bodyRect = body.getBoundingClientRect();
            var elRect = firstEl.getBoundingClientRect();
            body.scrollTop += (elRect.top - bodyRect.top) - 12;
            if (scrollDown && body.scrollHeight > body.clientHeight + 24) {
                var inputArea = doc.querySelector('.chat-input-area');
                if (inputArea) {
                    scrollDown.style.setProperty(
                        '--scroll-down-bottom',
                        (inputArea.offsetHeight + 12) + 'px'
                    );
                }
                scrollDown.hidden = false;
                scrollDown.classList.add('is-visible');
            }
        } else {
            scrollToBottom();
        }
    }

    if (scrollDown) {
        scrollDown.addEventListener('click', function () {
            body.scrollTo({ top: body.scrollHeight, behavior: 'smooth' });
        });
    }

    body.addEventListener('scroll', function () {
        if (!scrollDown || !scrollDown.classList.contains('is-visible')) {
            return;
        }
        var atBottom = body.scrollTop + body.clientHeight >= body.scrollHeight - 24;
        if (atBottom) {
            scrollDown.classList.remove('is-visible');
            scrollDown.hidden = true;
        }
    });

    function ce(tag, className) {
        var node = doc.createElement(tag);
        if (className) {
            node.className = className;
        }
        return node;
    }
})();
