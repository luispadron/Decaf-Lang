/* File: location.h
 * ----------------
 * This file just contains features relative to the location structure
 * used to record the lexical position of a token or symbol.  This file
 * establishes the common definition for the yyltype structure, the global
 * variable yylloc, and a utility function to join locations you might
 * find handy at times.
 */

#ifndef YYLTYPE

/* Typedef: yyltype
 * ----------------
 * Defines the struct type that is used by the scanner to store
 * position information about each lexeme scanned.
 */
typedef struct yyltype {

    yyltype(int ts, int fl, int fc, int ll, int lc) : 
        timestamp{ts}, first_line{fl}, first_column{fc}, last_line{ll}, last_column{lc} { }

    yyltype() :
        timestamp{0}, first_line{1}, first_column{0}, last_line{0}, last_column{0} { }

    int timestamp;                 // you can ignore this field
    int first_line, first_column;
    int last_line, last_column;
    char *text;                    // you can also ignore this field
} yyltype;

#define YYLTYPE yyltype


/* Global variable: yylloc
 * ------------------------
 * The global variable holding the position information about the
 * lexeme just scanned.
 */
extern struct yyltype yylloc;


/* Function: Join
 * --------------
 * Takes two locations and returns a new location which represents
 * the span from first to last, inclusive.
 */
inline yyltype Join(yyltype first, yyltype last)
{
  yyltype combined;
  combined.first_column = first.first_column;
  combined.first_line = first.first_line;
  combined.last_column = last.last_column;
  combined.last_line = last.last_line;
  return combined;
}

/* Same as above, except operates on pointers as a convenience  */
inline yyltype Join(yyltype *firstPtr, yyltype *lastPtr)
{
  return Join(*firstPtr, *lastPtr);
}


#endif

