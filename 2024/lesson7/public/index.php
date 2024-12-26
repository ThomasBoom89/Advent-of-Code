<?php

use Thomas\Lesson7\Operation;

require_once '../vendor/autoload.php';

$lines       = getLines();
$operationsA = [
    Operation::ADD,
    Operation::MULTIPLY,
];
$operationsB = [
    Operation::ADD,
    Operation::MULTIPLY,
    Operation::CONCAT,
];
$sumA        = 0;
$sumB        = 0;
foreach ($lines as $line) {
    [$value, $numbers] = prepareLine($line);
    if (isValid($value, $numbers, $operationsA)) {
        $sumA += $value;
    }
    if (isValid($value, $numbers, $operationsB)) {
        $sumB += $value;
    }
}

echo 'Sum for A: ' . $sumA . PHP_EOL;
echo 'Sum for B: ' . $sumB;

function isValid(int $target, array $numbers, array $operations): bool
{
    $stack = [
        [
            'index' => 0,
            'value' => 0,
        ]
    ];
    while ($stack) {
        $current = array_pop($stack);

        foreach ($operations as $operation) {
            $value = match ($operation) {
                Operation::MULTIPLY => $current['value'] * $numbers[$current['index']],
                Operation::ADD      => $current['value'] + $numbers[$current['index']],
                Operation::CONCAT   => (int)($current['value'] . $numbers[$current['index']]),
            };

            if ($target === $value && $current['index'] === (count($numbers) - 1)) {
                return true;
            }

            if ($target < $value) {
                continue;
            }

            if ($current['index'] === (count($numbers) - 1)) {
                continue;
            }
            // append to stack
            $stack[] = [
                'index' => $current['index'] + 1,
                'value' => $value,
            ];
        }
    }

    return false;
}


function prepareLine(string $line): array
{
    [$value, $numbers] = explode(':', $line);
    $numbers = explode(' ', trim($numbers));

    return [(int)$value, $numbers];
}

function getLines(): array
{
    $filePath = "input";

    return file($filePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
}
