# Contribution Guidelines

Thank you for considering contributing to this project!  

---

## How to Contribute

### 1. Reporting Issues
- Use the **Issues tab** to report bugs or request features.
- Include:
  - A clear description of the problem or feature.
  - Steps to reproduce (if applicable).
  - Example code or screenshots where possible.

### 2. Suggesting Enhancements
- Open an **Issue** labeled `enhancement`.
- Describe:
  - The problem the enhancement solves.
  - Possible implementation ideas.
  - Expected impact (performance, usability, flexibility).

### 3. Code Standards
#### Style

1. Use Option Explicit in all modules/classes.
2. Follow consistent naming:
3. Prefix private Properties with p_ (e.g., p_Text, p_FontLayout).
4. Use PascalCase for public properties and methods.
5. Comment tricky logic blocks and external API calls.

#### Documentation
A Method only needs a Comment if
1. Its logic is complicated
2. Some obscure solution gives a big perfomance boost
3. Something is not clear from the code itself

Otherwise a Comment for the **Code** is not needed.
However, a Code Documentation is very Important.
A simple markdown File describing what the Code does and why it does it in the way it does it should be the minimum.

#### Testing
Provide sample usage in a test module or snippet.
If possible try to minimize the dependencies of your Code, as this eases Testing.