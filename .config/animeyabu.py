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
import urllib


#### Recurring funtions
def get_html(url):
    html = requests.get(url)
    return html.text

def get_soup(html):
    return BeautifulSoup(html, features="lxml")


#### Selecting anime
def selecting_series(results):
    for number, info in results.items():
        print(number, info['title'])
    selection = int(input("Which anime are you searching for? "))
    return selection

def search_animeyabu(anime):
    query = urllib.parse.quote_plus(anime)
    query_url = f"https://animeyabu.com/?s={query}"
    html =  get_html(query_url)
    soup = get_soup(html)
    animedict = {}
    for counter, result in enumerate(soup.find_all("a", attrs={"class": "clip-link"}), start = 1):
        animedict[counter] = {"title": result.get("title"), "link": result.get("href")}
    selection = selecting_series(animedict)
    return animedict[selection]

#### Parsing anime data up to episode links
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
                                 {"class": "video"}):
            episode_list.append(tag.find('a')['href'])
    return episode_list


#### Downloading episodes (uses yt-dlp)
def download_episodes(episode_list, series):
    qual = quality_selection()
    for count, link in enumerate(episode_list, start=1):
        filepath = f"~/Videos/{series}/{series} - {str(count).zfill(4)}.mp4"
        print(f"Downloading {filepath}")
        subprocess.run(f'yt-dlp -f {qual} -o "{filepath}" {link}', shell=True)


#### Playing episodes
def launch_mpv(episode_list):
    qual = quality_selection()
    episodes = " ".join(episode_list)
    mpv = subprocess.run(f"notify-send -t 3000 'Playing animeyabu playlist' && mpv --ytdl-format='{qual}' {episodes}", shell=True)
    return mpv




#URL's for testing
#url = "https://animeyabu.com/assistir/captain-tsubasa-2018/"
#url = "https://animeyabu.com/assistir/naruto-shippuden-online-hd/"
#url = "https://animeyabu.com/assistir/yakusoku-no-neverland-2nd-season/"

def getArgs():
    parser = argparse.ArgumentParser(description="Plays entire playlists from animeyabu on mpv")
    parser.add_argument("title", type=str, metavar="title", help="Search for anime title")
    parser.add_argument("-d", "--download", action="store_true", default=False, help="Download episodes")
    parser.add_argument("-u", "--url", action="store_true", default=False, help="Use anime url page to get episodes instead of searching by title")
    parser.add_argument("-q", "--quality", type=str, default="hd", help="Quality: either 'hd' or 'sd'")
    return parser.parse_args()

def quality_selection():
    qual = args.quality.lower()
    if qual == "hd":
        return 0
    if qual == "sd":
        return 1
    else:
        raise ValueError("The quality option has to be either 'sd' or 'hd'")


def url_flag():
    subprocess.run(f"notify-send -t 3000 'Loading animeyabu playlist\n {args.title}'", shell=True)
    page_list = get_pages(args.title)
    #print(page_list)
    episode_list = get_episodes(page_list)
    print(episode_list)
    print(len(episode_list))
    launch_mpv(episode_list)


def download_flag():
    selection = search_animeyabu(args.title)
    page_list = get_pages(selection["link"])
    episode_list = get_episodes(page_list)
    download_episodes(episode_list, selection["title"])

def watch_episodes():
    selection = search_animeyabu(args.title)
    page_list = get_pages(selection["link"])
    episode_list = get_episodes(page_list)
    launch_mpv(episode_list)

if __name__ == "__main__":
    args = getArgs()
    if args.url:
        #print(f"url value: {args.url}")
        url_flag()
    if args.download:
        #print(f"download value: {args.download}")
        download_flag()
    else:
        watch_episodes()
