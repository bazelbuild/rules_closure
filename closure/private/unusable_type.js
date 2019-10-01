/** @externs @fileoverview
 * The Closure Compiler generates an UnusuableType reference when generating ijs
 * when it cannot find a definition of a type. In order to avoid a
 * JSC_BAD_TYPE_ANNOTATION warning in these cases, define the UnusableTYpe to be
 * the top type *.
*/
/** @typedef {*} */
var UnusableType;
