class Solution:
    def isPalindrome(self, x: int) -> bool:
        if x < 0 or (x % 10 == 0 and x != 0):
            return False
        halfrev = 0
        while halfrev < x:
            halfrev = halfrev * 10 + (x % 10)
            x //= 10
        return halfrev == x or halfrev // 10 == x 