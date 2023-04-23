/// Write a recursive function called reverse which accepts a string and returns a new string in reverse.
///
/// reverse('awesome') // 'emosewa'
/// reverse('rithmschool') // 'loohcsmhtir'

void main() {
  print(reverse('awesome'));
}

// Input: String
// Output: The reverse of the input string
reverse(String str) {
  // If the str is empty, then return (the base case).
  if (str.isEmpty) return str;

  // return last char of str + reverse() of str excluding last char.
  final lastIndex = str.length - 1;
  return str[lastIndex] + reverse(str.substring(0, lastIndex));
}
