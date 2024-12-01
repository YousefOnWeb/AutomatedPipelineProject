import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

class UITests(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()

    def test_submit_form(self):
        driver = self.driver
        driver.get("http://127.0.0.1:5000/")
        
        input_box = driver.find_element(By.NAME, "input_text")
        submit_button = driver.find_element(By.XPATH, "//input[@type='submit']")
        
        input_box.send_keys("UI Test")
        submit_button.click()
        
        self.assertIn("You entered: UI Test", driver.page_source)

    def tearDown(self):
        self.driver.quit()

if __name__ == '__main__':
    unittest.main()
