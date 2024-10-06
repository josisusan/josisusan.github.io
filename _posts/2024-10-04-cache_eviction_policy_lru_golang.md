---
layout: post
title: "Cache Eviction Policy: LRU"
date: "2024-10-04"
category: [golang]
tags: cache lru golang
---
Caching is an essential optimization technique widely used in modern software development. Whether it's retrieving data from a database or making requests to external services, caching helps reduce latency and improves performance. When dealing with external services, if the response doesn't change frequently, caching allows us to reuse the same data across multiple calls, saving time and resources.

However, one of the most challenging aspects of caching is deciding when to invalidate or evict cached data—this is where cache eviction policies come into play. These policies guide us in determining which items to remove from the cache when it becomes full. Effective cache management is crucial because memory, which is both limited and expensive, must be used efficiently to store only the most relevant data.

There are several cache eviction policies, each with different strategies for handling full caches. One blog post I came across on Codeacademy does a great job explaining these policies with examples, offering insights into their real-world application. In this post, however, we will focus on one of the most popular eviction strategies: the Least Recently Used (LRU) policy. We’ll explore how the LRU policy works and how it can be implemented in Golang to optimize cache management when memory resources are constrained.

Let us first design a struct to reprsent the cache. Here the size defines the maximum number of items that cache can store. The items are stored in a map with the key as the string and value as the item struct. The `item` struct contains the value and the time it was stored. Assuming the key and value are both strings for simplicity.

```golang
packge main

type item struct {
	value    string
	storedAt time.Time
}

type LRUCache struct {
	mutex sync.Mutex
	items map[string]item
	size  int
}

func NewLRUCache(size int) *LRUCache {
	return &LRUCache{
		items: make(map[string]item),
		size:  size,
	}
}
```

Now, lets define the `Get` and `Set` methods to store and retrieve the fromt the cache. Also, we will define `All()` method get all the result from the cache stored at the moment.

```golang
func (lru *LRUCache) Set(key string, value string) {
	var (
		needToDeleteKey string
		oldestTime      time.Time
	)
	lru.mutex.Lock()
	defer lru.mutex.Unlock()
	if len(lru.items) >= lru.size {
		oldestTime = time.Now()
		for k, v := range lru.items {
			if oldestTime.After(v.storedAt) {
				needToDeleteKey = k
				oldestTime = v.storedAt
			}
		}
	}
	if needToDeleteKey != "" {
		delete(lru.items, needToDeleteKey)
	}
	lru.items[key] = item{value: value, storedAt: time.Now()}
}

func (lru *LRUCache) Get(key string) (T, bool) {
	lru.mutex.Lock()
	defer lru.mutex.Unlock()
	var i item
	if i, found := lru.items[key]; found {
		i.storedAt = time.Now()
		lru.items[key] = i
		return i.value, found
	}
	return i.value, false
}

func (lru *LRUCache) All() map[string]string {
	lru.mutex.Lock()
	defer lru.mutex.Unlock()
	output := map[string]string{}
	for key, val := range lru.items {
		output[key] = val.value
	}
	return output
}
```

Now, we can use the struct in main function to test

```golang
func main() {
	lru := NewLRUCache(2)
	lru.Set("key1", "value1")
	lru.Set("key2", "value2")
	lru.Get("key1")
	lru.Set("key3", "value3")
	fmt.Println(lru.All())
}
```
When we run the code above using command `go run main.go`, we would get the output shown below
```bash
$ go run main.go
map[key1:value1 key3:value3]
```
The output shows that the least recently used item `key2` was removed from the cache when the cache was full. This is the essence of the LRU policy: when the cache is full, the least recently accessed item is evicted to make room for new items.

