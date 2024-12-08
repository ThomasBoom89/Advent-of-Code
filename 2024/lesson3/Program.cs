using System.Text.RegularExpressions;

LessonA();
LessonB();

void LessonB()
{
    Regex newRegex = new Regex("(mul\\((?<first>\\d{1,3}),(?<second>\\d{1,3})\\))");
    Regex greedRegex =
        new Regex("^((?<greed>.*?)(don't\\(\\)))((.*?)(do\\(\\))(?<greed>.*?)(don't\\(\\)))*(.*do\\(\\)(?<greed>.*))$",
            RegexOptions.Singleline);
    string parsedText = File.ReadAllText(@"./../../../input");
    int sum = 0;
    MatchCollection matches = greedRegex.Matches(parsedText);
    foreach (Match match in matches)
    {
        foreach (Capture capture in match.Groups["greed"].Captures)
        {
            MatchCollection matchCollection = newRegex.Matches(capture.Value);
            foreach (Match singleMatch in matchCollection)
            {
                sum += int.Parse(singleMatch.Groups["first"].Value) * int.Parse(singleMatch.Groups["second"].Value);
            }
        }
    }

    Console.WriteLine(sum);
}

void LessonA()
{
    Regex newRegex = new Regex("(mul\\((?<first>\\d{1,3}),(?<second>\\d{1,3})\\))");
    string parsedText = File.ReadAllText(@"./../../../input");
    MatchCollection matchCollection = newRegex.Matches(parsedText);
    int sum = 0;
    foreach (Match match in matchCollection)
    {
        sum += int.Parse(match.Groups["first"].Value) * int.Parse(match.Groups["second"].Value);
    }

    Console.WriteLine(sum);
}

int Sum(MatchCollection matches1, Regex regex, int i, string group)
{
    foreach (CaptureCollection coll in matches1[0].Groups[group].Captures)
    {
        foreach (Capture shit in coll)
        {
            MatchCollection matchCollection = regex.Matches(shit.Value);
            foreach (Match singleMatch in matchCollection)
            {
                i += int.Parse(singleMatch.Groups["first"].Value) * int.Parse(singleMatch.Groups["second"].Value);
            }
        }
    }

    return i;
}