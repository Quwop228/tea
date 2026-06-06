<?php

trait FullTextQuery
{

    protected function tokenize(string $query): array
    {
        $parts = preg_split('/[^\p{L}\p{N}]+/u', mb_strtolower(trim($query))) ?: [];
        $tokens = [];
        foreach ($parts as $part) {
            if ($part !== '' && mb_strlen($part) >= 2) {
                $tokens[] = $part;
            }
        }
        return $tokens;
    }

    protected function booleanQuery(string $query): string
    {
        $tokens = $this->tokenize($query);
        if (!$tokens) {
            return '';
        }
        return implode(' ', array_map(static function ($t) {
            return $t . '*';
        }, $tokens));
    }
}
