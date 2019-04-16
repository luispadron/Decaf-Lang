//
// Created by Luis on 2019-04-14.
//

#ifndef OPTIMIZATION_ADJ_LIST_H
#define OPTIMIZATION_ADJ_LIST_H

#include <iostream>
#include <iterator>
#include <map>
#include <unordered_set>

template<typename T>
class AdjacencyList {
public:

    using Edges = std::unordered_set<T>;
    using List = std::map<T, Edges>;
    using Colors = std::map<T, int>;

    /// adds vertex `a` into the graph
    void add(const T &a) {
        list.insert(std::make_pair(a, Edges()));
    }

    /// adds an undirected edge betweeen vertex `a` and vertex `b`
    void add_edge(const T &a, const T &b) {
        list[a].insert(b);
        list[b].insert(a);
    }

    /// removes vertex at given iterator `a` and all its edges from the graph
    /// use this method when iterating through the graph and deletion is required
    typename List::iterator erase(typename List::iterator it) {
        for (auto &kv : list) {
            kv.second.erase(it->first);
        }

        return list.erase(it);
    }

    /// removes edge between `a` and `b` from the graph
    void erase_edge(const T &a, const T &b) {
        list[a].erase(b);
        list[b].erase(a);
    }

    /// returns whether there is an edge between `a` and `b`
    bool has_edge(const T &a, const T &b) noexcept {
        return list[a].find(b) != list[a].end();
    }

    /// returns a list of edges for the given vertex `a`
    const Edges & get_edges(const T &a) const {
        auto it = list.find(a);
        if (it == list.end()) throw "error: no such vertex exists!";
        return it->second;
    }

    /// returns the degrees (edges) that `a` has
    int get_degrees(const T &a) const {
        auto it = list.find(a);
        if (it == list.end()) throw "error: no such vertex exists!";
        return it->second.size();
    }

    /// returns the color that vertex `a` has
    int get_color(const T &a) const {
        auto it = colors.find(a);
        if (it == colors.end()) return 0;
        return it->second;
    }

    void set_color(const T &a, int color) {
        colors[a] = color;
    }

    /// returns whether or not the current graph is empty, that is, no vertices
    bool empty() const {
        return list.empty();
    }

    typename List::iterator begin() {
        return list.begin();
    }

    typename List::iterator end() {
        return list.end();
    }

    void print() {
        for (auto &kv : list) {
            std::cout << "v: " << kv.first->GetName() << std::endl;
            std::cout << "e:";
            for (auto *loc : kv.second) {
                std::cout << "\t" << loc->GetName();
            }
            std::cout << std::endl << std::endl;
        }
    }

private:
    List list;
    Colors colors;
};

#endif //OPTIMIZATION_ADJ_LIST_H
