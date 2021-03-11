#!/usr/bin/env python3
"""
Script to run multiple episodes from crunchyroll

Author: Gabriel Alves Vieira
email: gabrieldeusdeth@gmail.com
github: https://github.com/gavieira
Date: 10/03/2021
"""


from selenium import webdriver
from bs4 import BeautifulSoup
import subprocess 
import argparse


def get_html(url):
    '''Part of crunchyroll's html is generated on the browser by javaascript
    So, a simple request will not get the episode links, for instance
    That's why selenium, firefox and geckodriver are needed
    Links:
    https://stackoverflow.com/questions/2148493/scrape-html-generated-by-javascript-with-python
    https://www.infoq.com/br/articles/headless-selenium-browsers/
    '''
    options = webdriver.FirefoxOptions()
    options.headless = True #Headless means the browser will run in the background
    driver = webdriver.Firefox(options=options)
    
    driver.get(url)
    html = driver.page_source #Getting the javascript rendered html
    #driver.save_screenshot('screen.png') # save a screenshot to disk
    driver.quit()
    return html

def get_soup(html):
    return BeautifulSoup(html, features="lxml")


def get_episodes(soup):
    episode_list = []
    for tag in soup.find_all("a", {"class": "portrait-element block-link titlefix episode"}):
        episode_list.append(f"https://www.crunchyroll.com{tag['href']}") #Adding full episode link to list
    episode_list.reverse() #Reversing list because crunchyroll automatically sorts from last to first episode
    return episode_list

def launch_mpv(episode_list):
    episodes = " ".join(episode_list)
    mpv = subprocess.run(f"notify-send -t 3000 'Playing crunchyroll playlist' && mpv {episodes}", shell=True)
    return mpv

def getArgs():
    parser = argparse.ArgumentParser(description="Plays entire playlists from crunchyroll on mpv")
    parser.add_argument("url", type=str, metavar="URL", help="Url of the crunchyroll playlist")
    return parser.parse_args()

if __name__ == "__main__":
    args = getArgs()
    subprocess.run(f"notify-send -t 3000 'Loading crunchyroll playlist\n {args.url}'", shell=True)
    #print(page_list)
    soup = get_soup(get_html(args.url))
    episode_list = get_episodes(soup)
    #print(episode_list)
    #print(len(episode_list))
    launch_mpv(episode_list)
