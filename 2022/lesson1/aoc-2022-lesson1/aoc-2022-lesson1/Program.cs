LessonA();
LessonB();

void LessonA()
{
    List<int> elves = new List<int>();
    int currentElf = 0;
    string parsedText = File.ReadAllText(@"../../../../../input.txt");
    foreach (string elfEntries in parsedText.Split("\n\n"))
    {
        currentElf = 0;
        foreach (string entry in elfEntries.Split("\n"))
        {
            if (entry == "")
            {
                continue;
            }

            currentElf += Int32.Parse(entry);
        }

        elves.Add(currentElf);
    }

    Console.WriteLine(elves.Max());
}

void LessonB()
{
    List<int> elves = new List<int>();
    int currentElf = 0;
    string parsedText = File.ReadAllText(@"../../../../../input.txt");
    foreach (string elfEntries in parsedText.Split("\n\n"))
    {
        currentElf = 0;
        foreach (string entry in elfEntries.Split("\n"))
        {
            if (entry == "")
            {
                continue;
            }

            currentElf += Int32.Parse(entry);
        }

        elves.Add(currentElf);
    }

    List<int> elvesOrdered = elves.OrderDescending().ToList();

    Console.WriteLine(elvesOrdered[0] + elvesOrdered[1] + elvesOrdered[2]);
}