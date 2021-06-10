## Crawler
Based on https://github.com/gocolly/colly

## Flags:
```bash
./crawler --help
Usage of ./crawler:
  -daemon
    	Run crawler on daemon mode
  -delay int
    	Delay is the duration to wait before creating a new request to the matching domains (default 1)
  -domain string
    	Set url for crawling. Example: https://example.com
  -header string
    	Set header for crawler request. Example: header_name:header_value
  -parallelism int
    	Parallelism is the number of the maximum allowed concurrent requests of the matching domains (default 2)
  -sleep int
    	Time in seconds to wait before run crawler again (default 60)
```
