goog.module('rules_closure.Lenient');

// Without "lenient = True" on the lenient_lib target, this line fails with
// "ERROR - Function must have JSDoc".
exports = function() {
    return 123;
};
