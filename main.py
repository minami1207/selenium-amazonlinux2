from selenium import webdriver
from selenium.webdriver.common.by import By


def handler(event=None, context=None):

    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    options.add_argument('--no-sandbox')
    options.add_argument("--disable-gpu")
    options.add_argument("--disable-software-rasterizer")
    options.add_argument("--window-size=1280x1696")
    options.add_argument("--single-process")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-dev-tools")
    options.add_argument("--no-zygote")
    options.add_argument("--disable-dev-shm-usage")
    options.binary_location = "/opt/chrome-linux64/chrome"

    driver = webdriver.Chrome(options=options)
    driver.get("https://yahoo.co.jp/")

    print(driver.find_element(By.TAG_NAME, "body").text)

    return driver.find_element(By.TAG_NAME, "body").text

if __name__ == "__main__":
    handler()
