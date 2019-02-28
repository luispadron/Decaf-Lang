/* File: list.h
 * ------------
 * Simple list class for storing a linear collection of elements. It
 * supports operations similar in name to the CS107 DArray -- nth, insert,
 * append, remove, etc.  This class is nothing more than a very thin
 * cover of a STL deque, with some added range-checking. Given not everyone
 * is familiar with the C++ templates, this class provides a more familiar
 * interface.
 *
 * It can handle elements of any type, the typename for a List includes the
 * element type in angle brackets, e.g.  to store elements of type double,
 * you would use the type name List<double>, to store elements of type
 * Decl *, it woud be List<Decl*> and so on.
 *
 * Here is some sample code illustrating the usage of a List of integers
 *
 *   int Sum(List<int> *list)
 *   {
 *       int sum = 0;
 *       for (int i = 0; i < list->size(); i++) {
 *          int val = list->Nth(i);
 *          sum += val;
 *       }
 *       return sum;
 *    }
 */

#ifndef _H_list
#define _H_list

#include "Symbol_table.h"
#include "utility.h"  // for Assert()

#include <deque>
#include <algorithm>
  
class Node;

template<class Element> class List {

private:
    std::deque<Element> elems;

public:
    /// Create a new empty list
    List() = default;

    /// Copy a list
    List(const List<Element> &lst) : elems(lst.elems) {}

    /// Clear the list
    void clear() {
        elems.clear();
    }

    /// Returns count of elements currently in list
    int size() const {
        return static_cast<int>(elems.size());
    }

    /// Returns element at index in list. Indexing is 0-based.
    /// Raises an assert if index is out of range.
    Element get(int index) const {
        Assert(index >= 0 && index < size());
        return elems[index];
    }

    /// Inserts element at index, shuffling over others
    /// Raises assert if index out of range
    void insert(const Element &elem, int index) {
        Assert(index >= 0 && index <= size());
        elems.insert(elems.begin() + index, elem);
    }

    /// Adds element to list end
    void append(const Element &elem) {
        elems.push_back(elem);
    }

    /// Adds all elements to list end
    void append(const List<Element> &lst) {
        for (int i = 0; i < lst.size(); i++) {
            append(lst.get(i));
        }
    }

    /// Removes element at index, shuffling down others
    /// Raises assert if index out of range
    void remove(int index) {
        Assert(index >= 0 && index < size());
        elems.erase(elems.begin() + index);
   }

	/// Removes all elements of a specific value
    void remove(const Element &elem) {
        elems.erase(std::remove(elems.begin(), elems.end(), elem), elems.end());
    }

    /// Sort and remove repeated elements
    void unique() {
        std::sort(elems.begin(), elems.end());
	    elems.erase(std::unique(elems.begin(), elems.end()), elems.end());
    }
          
    /// These are some specific methods useful for lists of ast nodes
    /// They will only work on lists of elements that respond to the
    /// messages, but since C++ only instantiates the template if you use
    /// you can still have Lists of ints, chars*, as long as you
    /// don't try to SetParentAll on that list.
    void set_parent_all(Node *p) {
        for (int i = 0; i < size(); i++) {
            get(i)->set_parent(p);
        }
    }

    /// calls the `Check` function for all Nodes in the list
    void check_all(Symbol_table<std::string, Node *> &sym_table) {
        for (int i = 0; i < size(); ++i) {
            get(i)->check(sym_table);
        }
    }
};

#endif

