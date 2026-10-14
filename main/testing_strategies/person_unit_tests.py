import unittest

class MyTests(unittest.TestCase):
    def setUp(self):
        self.name = "Marin"
        self.age = 43
        self.job = "dev"
        self.wage = 350.00
        self.savings = 3000

    def test_correct_init(self):
        self.assertEqual(self.name, "Marin")
        self.assertEqual(self.age, 43)
        self.assertEqual(self.job, "dev")
        self.assertEqual(self.wage, 350.00)
        self.assertEqual(self.savings, 3000)

    def test_increase_savings_by_adding_wage(self):
        self.savings += self.wage
        self.assertEqual(self.savings, 3350.00)

if __name__ == "__main__":
   unittest.main() 