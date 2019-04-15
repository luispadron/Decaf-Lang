//
// Created by Luis on 2019-04-14.
//

#ifndef OPTIMIZATION_ADJ_LIST_H
#define OPTIMIZATION_ADJ_LIST_H

#include <map>
#include <unordered_set>

template<typename T>
class AdjacencyList {
public:

    using Edges = std::unordered_set<T>;

    void add_edge(const T &a, const T &b) {
        list[a].insert(b);
        list[b].insert(a);
    }

    bool has_edge(const T &a, const T &b) const {
        return list[a].find(b) != list[a].end();
    }

    void remove_edge(const T &a, const T &b) {
        list[a].erase(b);
        list[b].erase(a);
    }

    template <typename F>
    void traverse(F fn) {
        for (const auto &kv : list) {
            fn(kv.first, kv.second);
        }
    }

private:
    using List = std::map<T, Edges>;
    List list;
};

#endif //OPTIMIZATION_ADJ_LIST_H
