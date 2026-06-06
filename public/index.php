<?php

declare(strict_types=1);

$suggestions = [];
try {
    require __DIR__ . '/../src/Database.php';
    $stmt = Database::connection()->query(
        'SELECT text FROM suggestions WHERE is_active = 1 ORDER BY sort_order ASC, id ASC'
    );
    $suggestions = $stmt->fetchAll(PDO::FETCH_COLUMN);
} catch (Throwable $e) {
    $suggestions = [
        'Чайные новинки', 'Чай для бодрости', 'Чай для сна', 'Как заваривать чай',
        'Чайные церемонии', 'Чай для медитации', 'Какой чай улучшает пищеварение',
        'В каких чаях нет кофеина',
    ];
}

function e(string $value): string
{
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}
?>
<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title>Art of Tea — Персональный ассистент</title>
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/chat.css">
</head>
<body>

<header class="site-header">

    <div class="mobile-header">
        <button class="mobile-header__btn" type="button" aria-label="Поддержка">
            <img src="assets/icons/support.svg" alt="">
        </button>
        <a class="logo" href="#"><img class="logo__text" src="assets/icons/logo.svg" alt="ART OF TEA"><img class="logo__leaf" src="assets/icons/leaf.svg" alt="" aria-hidden="true"></a>
        <button class="mobile-header__btn" type="button" aria-label="Поиск">
            <img src="assets/icons/search.svg" alt="">
        </button>
    </div>

    <div class="topbar">
        <div class="container topbar__inner">
            <div class="topbar__left">
                <a class="topbar__link" href="#">
                    <img class="ic" src="assets/icons/support.svg" alt="" aria-hidden="true">
                    Поддержка
                </a>
                <button class="topbar__link" type="button">
                    <img class="ic" src="assets/icons/location.svg" alt="" aria-hidden="true">
                    Москва
                </button>
            </div>

            <a class="logo" href="#"><img class="logo__text" src="assets/icons/logo.svg" alt="ART OF TEA"><img class="logo__leaf" src="assets/icons/leaf.svg" alt="" aria-hidden="true"></a>

            <nav class="topnav">
                <a href="#">Бонусы</a>
                <a href="#">О нас</a>
                <a href="#">Доставка и оплата</a>
                <a href="#">Контакты</a>
                <a href="#">Опт</a>
            </nav>
        </div>
    </div>

    <div class="actionbar">
        <div class="container actionbar__inner">
            <button class="btn-catalog" type="button">
                <img class="ic" src="assets/icons/menu.svg" alt="" aria-hidden="true">
                Каталог
            </button>

            <form class="search" role="search" onsubmit="return false">
                <img class="search__icon" src="assets/icons/search.svg" alt="" aria-hidden="true">
                <input class="search__field" type="search" placeholder="Найти" aria-label="Поиск по сайту">
            </form>

            <div class="header-actions">
                <button class="header-action" type="button">
                    <img class="ic" src="assets/icons/heart.svg" alt="" aria-hidden="true">
                    <span>Избранное</span>
                </button>
                <button class="header-action header-cart" type="button">
                    <span class="header-cart__wrap">
                        <img class="ic" src="assets/icons/bag.svg" alt="" aria-hidden="true">
                        <span class="header-cart__badge" aria-hidden="true"></span>
                    </span>
                    <span>Корзина</span>
                </button>
                <a class="btn-account" href="#">Личный кабинет</a>
            </div>
        </div>
    </div>
</header>

<main>

    <section class="banner" id="assistantBanner">
        <div class="container">
            <div class="banner__slider">
                <div class="banner__track" id="bannerTrack">

                    <div class="banner__slide banner__card" data-open-chat role="button" tabindex="0" aria-label="Открыть персонального ассистента">
                        <picture class="banner__bg">
                            <source media="(max-width: 600px)" srcset="assets/img/banner-mobile.jpg">
                            <img src="assets/img/banner-desktop.jpg" alt="" loading="eager">
                        </picture>

                        <div class="banner__content">
                            <h1 class="banner__title">ПЕРСОНАЛЬНЫЙ<br>АССИСТЕНТ</h1>
                            <button class="banner__cta" type="button" data-open-chat>
                                <img class="banner__cta-icon" src="assets/icons/sparkle.svg" alt="" aria-hidden="true"> Ввести запрос
                            </button>
                        </div>

                        <div class="banner__bubble">
                            <p>Добрый день!</p>
                            <p>Я ваш личный ассистент</p>
                            <p>Чем я могу помочь?</p>
                            <svg class="banner__bubble-tail" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M0 0 C0 11 2 19 23 22 C13 16 10 8 10 0 Z" fill="#F4F4F4"/>
                            </svg>
                        </div>

                        <img class="banner__character" src="assets/img/character.png" alt="Чайный ассистент">
                    </div>

                    <div class="banner__slide banner__card promo" aria-hidden="true">
                        <picture class="banner__bg">
                            <source media="(max-width: 760px)" srcset="assets/img/promo-cashback-mobile.jpg">
                            <img src="assets/img/promo-cashback.jpg" alt="">
                        </picture>
                        <div class="promo__content">
                            <div class="promo__head">
                                <h2 class="promo__title">КЭШБЭК<br>БАЛЛАМИ</h2>
                                <span class="promo__percent">10%</span>
                            </div>
                            <button class="promo__btn" type="button">Подробнее о программе</button>
                        </div>
                    </div>
                </div>

                <div class="banner__dots" id="bannerDots">
                    <button class="is-active" type="button" aria-label="Слайд 1"></button>
                    <button type="button" aria-label="Слайд 2"></button>
                </div>
            </div>
        </div>
    </section>

    <section class="popular">
        <div class="container">
            <h2 class="popular__title">Популярное</h2>
            <div class="popular__stub">тут ничего нет :)</div>
        </div>
    </section>
</main>

<button class="chat-fab" id="chatFab" type="button" data-open-chat aria-label="Открыть ассистента">
    <img src="assets/img/avatar.png" alt="">
</button>

<nav class="tabbar" aria-label="Навигация">
    <a class="tabbar__item is-active" href="#">
        <span class="tabbar__icon" aria-hidden="true"></span>
        <span>Главная</span>
    </a>
    <button class="tabbar__item" type="button" data-open-chat>
        <span class="tabbar__icon" aria-hidden="true"></span>
        <span>Ассистент</span>
    </button>
    <a class="tabbar__item" href="#">
        <span class="tabbar__icon" aria-hidden="true"></span>
        <span>Меню</span>
    </a>
    <a class="tabbar__item" href="#">
        <span class="tabbar__icon" aria-hidden="true"></span>
        <span>Корзина</span>
    </a>
    <a class="tabbar__item" href="#">
        <span class="tabbar__icon" aria-hidden="true"></span>
        <span>Профиль</span>
    </a>
</nav>

<div class="chat-modal" id="chatModal" aria-hidden="true" role="dialog" aria-modal="true" aria-label="Чат с ассистентом">
    <div class="chat-modal__inner">
        <img class="chat-side-character" src="assets/img/character.png" alt="" aria-hidden="true">
        <header class="chat-header">
            <a class="logo" href="#"><img class="logo__text" src="assets/icons/logo.svg" alt="ART OF TEA"><img class="logo__leaf" src="assets/icons/leaf.svg" alt="" aria-hidden="true"></a>
            <div class="chat-header__actions">
                <button class="chat-header__icon" type="button" aria-label="Избранное">
                    <img class="chat-header__glyph" src="assets/icons/heart.svg" alt="" aria-hidden="true">
                    <span class="chat-header__label">Избранное</span>
                </button>
                <button class="chat-header__icon chat-cart" type="button" aria-label="Корзина">
                    <img class="chat-header__glyph" src="assets/icons/bag.svg" alt="" aria-hidden="true">
                    <span class="chat-header__label">Корзина</span>
                    <span class="chat-cart__badge" id="cartBadge" hidden>0</span>
                </button>
                <button class="chat-header__close" id="chatClose" type="button">
                    <span class="chat-header__close-text">Закрыть</span>
                    <span class="chat-header__close-x" aria-hidden="true">✕</span>
                </button>
            </div>
        </header>

        <div class="chat-body" id="chatBody">
            <div class="chat-greeting" id="chatGreeting">
                <h2 class="chat-greeting__title">Чем я могу помочь?</h2>
            </div>

            <div class="chat-messages" id="chatMessages" aria-live="polite"></div>
        </div>

        <button class="chat-scroll-down" id="chatScrollDown" type="button" aria-label="К ответу" hidden></button>

        <div class="chat-input-area">
            <div class="chat-input">
                <textarea id="chatInput" class="chat-input__field" maxlength="500" rows="1"
                          placeholder="Введите ваш запрос"></textarea>
                <button class="chat-send" id="chatSend" type="button" aria-label="Отправить"></button>
            </div>
            <div class="chat-suggestions" id="chatSuggestions">
                <?php foreach ($suggestions as $text): ?>
                    <button class="chip" type="button"><?= e((string) $text) ?></button>
                <?php endforeach; ?>
            </div>
            <div class="chat-suggestions-dots" id="chatSuggestionsDots" aria-hidden="true"></div>
        </div>
    </div>
</div>

<script src="assets/js/chat.js"></script>
</body>
</html>
