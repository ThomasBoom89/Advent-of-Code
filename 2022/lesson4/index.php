<?php

declare(strict_types=1);

lessonA();
echo PHP_EOL;
lessonB();

function lessonA(): void
{
    $filePath = "input.txt";

    $fileHandle = fopen(filename: $filePath, mode: 'rb');

    $input = fread($fileHandle, filesize($filePath));

    fclose($fileHandle);

    $count = 0;
    foreach (explode("\n", $input) as $line) {
        $elves = explode(",", $line);
        $elfA  = explode("-", $elves[0]);
        $elfB  = explode("-", $elves[1]);

        if (
            ($elfA[0] <= $elfB[0] && $elfA[1] >= $elfB[1])
            || ($elfB[0] <= $elfA[0] && $elfB[1] >= $elfA[1])
        ) {
            $count++;
        }
    }

    echo $count;
}

function lessonB(): void
{
    $filePath = "input.txt";

    $fileHandle = fopen(filename: $filePath, mode: 'rb');

    $input = fread($fileHandle, filesize($filePath));

    fclose($fileHandle);

    $count = 0;
    foreach (explode("\n", $input) as $line) {
        $elves = explode(",", $line);
        $elfA  = explode("-", $elves[0]);
        $elfB  = explode("-", $elves[1]);

        if (
            ($elfA[0] <= $elfB[0] && $elfA[0] >= $elfB[1])
            || ($elfA[0] <= $elfB[1] && $elfA[1] >= $elfB[1])
            || ($elfB[0] <= $elfA[0] && $elfB[0] >= $elfA[1])
            || ($elfB[0] <= $elfA[1] && $elfB[1] >= $elfA[1])
        ) {
            $count++;
        }
    }

    echo $count;
}
