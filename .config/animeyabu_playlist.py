#!/usr/bin/env python3
"""
Script to run multiple episodes from animeyabu.com

Author: Gabriel Alves Vieira
email: gabrieldeusdeth@gmail.com
github: https://github.com/gavieira
Date: 10/03/2021
"""


from bs4 import BeautifulSoup
import requests
import subprocess 
import argparse


def get_html(url):
    html = requests.get(url)
    return html.text


def get_soup(html):
    return BeautifulSoup(html, features="lxml")


def get_next_page(soup):
    for anchor in soup.find_all("a", 
                                {"class": "next page-numbers"},
                               limit = 1):
        return anchor["href"]


def get_pages(url):
    #Gets the next page from baselink
    page_list = [url]
    soup = get_soup(get_html(url))
    next_url = get_next_page(soup) 
    #Enters in a while loop to get subsequent pages
    while next_url:
        page_list.append(next_url)
        soup = get_soup(get_html(next_url))
        next_url = get_next_page(soup)
    return page_list


def get_episodes(page_list):
    episode_list = []
    for page in page_list:
        soup = get_soup(get_html(page))
        for tag in soup.find_all("div", 
                                 {"class": "anime-episode"}):
            episode_list.append(tag.find('a')['href'])
    return episode_list



def launch_mpv(episode_list):
    episodes = " ".join(episode_list)
    mpv = subprocess.run(f"notify-send -t 3000 'Playing goyabu playlist' && mpv {episodes}", shell=True)
    return mpv


#URL's for testing
#url = "https://goyabu.com/assistir/captain-tsubasa-2018/"
#url = "https://goyabu.com/assistir/naruto-shippuden-online-hd/"
#url = "https://goyabu.com/assistir/yakusoku-no-neverland-2nd-season/"

def getArgs():
    parser = argparse.ArgumentParser(description="Plays entire playlists from goyabu on mpv")
    parser.add_argument("url", type=str, metavar="URL", help="Url of the goyabu playlist")
    return parser.parse_args()

if __name__ == "__main__":
    args = getArgs()
    subprocess.run(f"notify-send -t 3000 'Loading goyabu playlist\n {args.url}'", shell=True)
    page_list = get_pages(args.url)
    #print(page_list)
    episode_list = get_episodes(page_list)
    #print(episode_list)
    #print(len(episode_list))
    launch_mpv(episode_list)
