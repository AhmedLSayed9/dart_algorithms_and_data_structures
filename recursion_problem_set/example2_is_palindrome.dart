/// Write a recursive function called isPalindrome which returns true if the string
/// passed to it is a palindrome (reads the same forward and backward). Otherwise it returns false.
///
/// isPalindrome('awesome') // false
/// isPalindrome('foobar') // false
/// isPalindrome('tacocat') // true
/// isPalindrome('amanaplanacanalpanama') // true
/// isPalindrome('amanaplanacanalpandemonium') // false

void main() {
  print(isPalindrome('tacocat'));
}

// Input: String
// Output: bool, if the passed string is palindrome
bool isPalindrome(String str) {
  // If str is empty or single char return true (the base case).
  if (str.length <= 1) return true;

  // compare first and last chars:
  // if they're the same return isPalindrome of str excluding first and last chars
  // or else return false
  final lastIndex = str.length - 1;
  if (str[0] == str[lastIndex]) {
    return isPalindrome(str.substring(1, lastIndex));
  }
  return false;
}
