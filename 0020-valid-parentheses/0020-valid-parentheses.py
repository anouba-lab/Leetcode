class Solution:
    def isValid(self, s: str) -> bool:
        previous_length = -1

        while previous_length != len(s):
            previous_length = len(s)
            s = s.replace("()", "", 1)
            s = s.replace("{}", "", 1)
            s = s.replace("[]", "", 1)

        return len(s) == 0
        