Imports System
Imports System.IO

Module Program
    Dim _length = 0

    Sub Main(args As String())
        Dim filePath As String = "./../../../input2"
        _length = File.ReadLines(filepath).ToList()(0).Length
        LessonA(filePath)
        lessonB(filePath)
    End Sub

    Private Sub LessonA(filepath As String)
        Dim lookup(_length, _length) As String
        Dim iter = 0
        For Each line As String in File.ReadLines(filepath)
            Dim charList = line.ToArray()
            Dim jiter = 0
            For Each charchar As String in charList
                lookup(iter, jiter) = charchar
                jiter = jiter + 1
            Next
            iter = iter + 1
        Next line
        Check(lookup)
    End Sub

    Private Sub LessonB(filepath As String)
        Dim lookup(_length, _length) As String
        Dim iter = 0
        For Each line As String in File.ReadLines(filepath)
            Dim charList = line.ToArray()
            Dim jiter = 0
            For Each charchar As String in charList
                lookup(iter, jiter) = charchar
                jiter = jiter + 1
            Next
            iter = iter + 1
        Next line
        Check2(lookup)
    End Sub

    Private Sub Check(lookup)
        Dim count = 0
        For y As Integer = 0 To _length - 1
            For x As Integer = 0 To _length - 1
                count = count + RealCheck(lookup, x, y)
            Next
        Next
        Console.WriteLine(count)
    End Sub

    Private Sub Check2(lookup)
        Dim count = 0
        For y As Integer = 0 To _length - 1
            For x As Integer = 0 To _length - 1
                count = count + RealCheck2(lookup, x, y)
            Next
        Next
        Console.WriteLine(count)
    End Sub

    Function RealCheck2(lookup, x, y) As Integer
        Dim current = lookup(y, x)
        If Not current.Equals("A")
            Return 0
        End If
        If (x - 1) < 0 Or (x + 1) > _length Or (y - 1) < 0 Or (y + 1) > _length
            Return 0
        End If

        If ((lookup(y - 1, x - 1) = "M" And lookup(y + 1, x + 1) = "S") Or (lookup(y - 1, x - 1) = "S" And lookup(y + 1, x + 1) = "M")) And ((lookup(y + 1, x - 1) = "M" And lookup(y - 1, x + 1) = "S") Or (lookup(y + 1, x - 1) = "S" And lookup(y - 1, x + 1) = "M"))
            Return 1
        End If

        Return 0
    End Function


    Function RealCheck(lookup, x, y) As Integer
        Dim current = lookup(y, x)
        Dim count = 0
        If Not current.Equals("X")
            Return 0
        End If
        'oben
        If CanGoUp(y)
            If lookup(y - 1, x) = "M" And lookup(y - 2, x) = "A" And lookup(y - 3, x) = "S"
                count = count + 1
            End If
        End If
        'oben-rechts
        If CanGoUp(y) And CanGoRight(x)
            If lookup(y - 1, x + 1) = "M" And lookup(y - 2, x + 2) = "A" And lookup(y - 3, x + 3) = "S"
                count = count + 1
            End If
        End If
        'rechts
        If CanGoRight(x)
            If lookup(y, x + 1) = "M" And lookup(y, x + 2) = "A" And lookup(y, x + 3) = "S"
                count = count + 1
            End If
        End If

        ' unten-rechts
        If CanGoRight(x) And CanGoDown(y)
            If lookup(y + 1, x + 1) = "M" And lookup(y + 2, x + 2) = "A" And lookup(y + 3, x + 3) = "S"
                count = count + 1
            End If
        End If

        ' unten
        If CanGoDown(y)
            If lookup(y + 1, x) = "M" And lookup(y + 2, x) = "A" And lookup(y + 3, x) = "S"
                count = count + 1
            End If
        End If

        'unten-left
        If CanGoLeft(x) And CanGoDown(y)
            If lookup(y + 1, x - 1) = "M" And lookup(y + 2, x - 2) = "A" And lookup(y + 3, x - 3) = "S"
                count = count + 1
            End If
        End If

        ' links
        If CanGoLeft(x)
            If lookup(y, x - 1) = "M" And lookup(y, x - 2) = "A" And lookup(y, x - 3) = "S"
                count = count + 1
            End If
        End If

        'oben-links
        If CanGoUp(y) And CanGoLeft(x)
            If lookup(y - 1, x - 1) = "M" And lookup(y - 2, x - 2) = "A" And lookup(y - 3, x - 3) = "S"
                count = count + 1
            End If
        End If

        return count
    End Function

    Function CanGoUp(y) As Boolean
        Return (y - 3) >= 0
    End Function

    Function CanGoRight(x) As Boolean
        Return (x + 3) < _length
    End Function

    Function CanGoDown(y) As Boolean
        Return (y + 3) < _length
    End Function

    Function CanGoLeft(x) As Boolean
        Return (x - 3) >= 0
    End Function
End Module
