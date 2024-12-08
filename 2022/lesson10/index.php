<?php

declare(strict_types=1);

lessonA();
echo PHP_EOL . PHP_EOL;
lessonB();

function lessonB(): void
{
    $lines = getLines();
    $x     = 1;
    $cycle = 0;
    $crt   = [];
    foreach (explode("\n", $lines) as $line) {
        if ($line === '') {
            break;
        }

        $lineSplitted = explode(" ", $line);

        [$cycle, $crt] = checkCycleLessonB($x, $cycle, $crt);

        if ($lineSplitted[0] !== 'noop') {
            [$cycle, $crt] = checkCycleLessonB($x, $cycle, $crt);
            $x += (int)$lineSplitted[1];
        }
    }
}

function lessonA(): void
{
    $lines          = getLines();
    $x              = 1;
    $cycle          = 0;
    $signalStrength = 0;
    foreach (explode("\n", $lines) as $line) {
        if ($line === '') {
            break;
        }

        $lineSplitted = explode(" ", $line);

        [$cycle, $signalStrength] = checkCycleLessonA($x, $cycle, $signalStrength);

        if ($lineSplitted[0] !== 'noop') {
            [$cycle, $signalStrength] = checkCycleLessonA($x, $cycle, $signalStrength);
            $x += (int)$lineSplitted[1];
        }
    }

    echo $signalStrength;
}

function checkCycleLessonB(int $x, int $cycle, array $crt): array
{
    $pixel = '.';
    if ($cycle >= $x - 1 && $cycle <= $x + 1) {
        $pixel = '#';
    }
    $cycle++;

    echo $pixel;

    if ($cycle % 40 === 0) {
        echo PHP_EOL;
        $cycle = 0;
    }

    return [$cycle, $crt];
}

function checkCycleLessonA(int $x, int $cycle, int $signalStrength): array
{
    $cycle++;
    if (in_array($cycle, [20, 60, 100, 140, 180, 220])) {
        $signalStrength += ($cycle * $x);
    }

    return [$cycle, $signalStrength];
}

/**
 * @throws RuntimeException
 */
function getLines(): string
{
    $filePath = "input.txt";

    $fileHandle = fopen(filename: $filePath, mode: 'rb');

    $content = fread($fileHandle, filesize($filePath));
    if ($content === false) {
        throw new RuntimeException("bang");
    }

    fclose($fileHandle);

    return $content;
}
