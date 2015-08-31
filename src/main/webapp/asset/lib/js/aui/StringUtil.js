/*
 * Anyframe UI Javascript Library
 *
 * - Extends the functionality of Standard built-in Date Object in javascript
 *
 * @author Sangjin, Nam (poethera@gmail.com, sangjiny.nam@samsung.com)
 * 
 */
(function(window, $) {

	_op_toString = Object.prototype.toString,
	_op_hasOwn = Object.prototype.hasOwnProperty;
	
	function _isType(src, comp) {
        if ( src === undefined ) {
            return undefined;
        }
        else if ( src === null ) {
            return  null;
        }

        return ( _op_toString.call(src).toLowerCase() === comp );
    }

	STRING={
	/**
         * <p>it extends dest object with src object, and as extending, you can choose the extendMode.<br>
         * extendMode supports different copy or extend options.<br><br>
         *
         * &lt;Kind of extendMode&gt;<br>
         * 1. "OE" : Only Extend <br>
         * 2. "OMC" : Only Matched Copy <br>
         * 3. "OEMC" : Matched Copy & Unmatched Extend <br>
         * </p>
         *
         * @param {object} dest destination object
         * @param {object} src source object
         * @param {string} [extendMode] Default is "OE". it's one of the following values ("OE" | "OMC" | "OEMC").
         * @returns {object} extended object
         */
        extendif: function(dest, src, extendMode) {         //TODO: if need reference copy ?, add shallow copy mode

            var mode = extendMode || "OE",
                exData = {},
                dest = dest || {}, src = src || {},
                srcProp;

            for (var name in src) {
                srcProp = src[name];

                if (mode === "OE" && dest[name] === undefined) {
                    dest[name] = this.copyObject(src[name]);
                }
                else if (mode === "OMC" && dest[name] !== undefined) {
                    dest[name] = this.copyObject(src[name]);
                }
                else if (mode === "OEMC") {  // OEMC mode
                    dest[name] = this.copyObject(src[name]);
                }
            }

            return dest;
        },

        /**
         * Copy object and Return the object with same value.
         * @param {object} src source object or array
         * @returns {object}
         */
        copyObject: function( src ) {
            var dest;

            if (this.isObject(src))
                dest = this.extendif({}, src);
            else if (this.isArray(src))
                dest = this.extendif([], src);
            else
                dest = src;

            return dest;
        },

        /**
         * Return true if the param is a object
         * @param {*} obj
         * @returns {boolean} if obj is undefined or null, return undefined or null value
         */
        isObject: function( obj ) {
            return _isType(obj, "[object object]");
        },

        /**
         * Return true if the param is a array
         * @param {*} obj
         * @returns {boolean} if obj is undefined, return undefined value
         */
        isArray: function( obj ) {
            return _isType(obj, "[object array]");
        },

        /**
         * Return true if the param is a String
         * @param {*} obj
         * @returns {boolean} if obj is undefined, return undefined value
         */
        isString: function( obj ) {
            return _isType(obj, "[object string]");
        },

        /**
         * Return true if the param is a Number
         * @param {*} obj
         * @returns {boolean} if obj is undefined, return undefined value
         */
        isNumber: function( obj ) {
            return _isType(obj, "[object number]");
        },

        /**
         * Return true if the param is a boolean type
         * @param {*} obj
         * @returns {boolean} if obj is undefined, return undefined value
         */
        isBoolean: function( obj ) {
            return _isType(obj, "[object boolean]");
        }
	};
	
	window.A = window.STRING = STRING;

}(window, jQuery));

(function(A) {

    "use strict";

    var bkindexof = String.prototype.indexOf,
        bklastindexof = String.prototype.lastIndexOf;

    /**
     * Extends the built-in String Object
     * @namespace String
     */

    A.extendif( String.prototype,
        /**
         * @lends String.prototype
         */
        {

        /**
         * Remove whitespace from the left end of string
         * @returns {string} return new string stripped the whitespace
         */
        trimLeft: function() {
            return this.replace(/^\s+/gm, '');
        },

        /**
         * Remove whitespace from the right end of string
         * @returns {string} return new string stripped the whitespace
         */
        trimRight: function() {
            return this.replace(/\s+$/gm, '');
        },

        /**
         * Return true if the two strings are same with case-sensitive mode, else false
         * @param {string} compStr
         * @returns {boolean}
         */
        compare: function(compStr) {
            if (this > compStr)
                return false;
            else if (this < compStr) {
                return false;
            }
            else
                return true;
        },

        /**
         * Return true if the two strings are same with case-insensitive mode, else false
         * @param {string} compStr
         * @returns {boolean}
         */
        compareNoCase: function(compStr) {
            var orgStr = this.toLowerCase(),
                cmpStr = compStr.toLowerCase();

            if (orgStr > cmpStr)
                return false;
            else if (orgStr < cmpStr) {
                return false;
            }
            else
                return true;
        },

        /**
         * Find the position of searching String in target String with case-insensitive mode
         * @param {string} searchString
         * @param {number} fromIndex the position to start the search
         * @returns {number}
         */
        indexOfNoCase: function(searchString, fromIndex) {
            return String.prototype.indexOf.call( this.toLowerCase(), searchString.toLowerCase(), fromIndex );
        },

        /**
         * Find the position of searching String backward in target String with case-insensitive mode
         * @param {string} searchString
         * @param {number} fromIndex the position to start the search
         * @returns {number}
         */
        lastIndexOfNoCase: function(searchString, fromIndex) {
            return String.prototype.lastIndexOf.call( this.toLowerCase(), searchString.toLowerCase(), fromIndex );
        },

        /**
         * Return the occurrence count of the search string
         * @param {string} searchString
         * @returns {Number} count
         */
        countMatch: function(searchString) {
            var rex = new RegExp(searchString, "gm"),
                match = this.match( rex );
            return ((match != null) ? match.length : 0);
        },

        /**
         * Verify whether input string is number string or not. if number, return true
         * @returns {boolean}
         */
        isNumber: function() {
            var match = this.match(/[^0-9]/gm);
            return (match === null);
        },

        /**
         * Verify whether input string is alphabet string or not. if alphabet, return true
         * @returns {boolean}
         */
        isAlpha: function() {
            var match = this.match(/[^a-zA-Z]/gm);
            return (match === null);
        },

        /**
         * Verify whether input string is alphabet and number string or not. if alphabet or number, return true
         * @returns {boolean}
         */
        isAlnum: function() {
            var match = this.match(/[^0-9a-zA-Z]/gm);
            return (match === null);
        },

        /**
         * Verify whether input string is alphabet and space string or not. if alphabet or space, return true
         * @returns {boolean}
         */
        isAlnumSpace: function() {
            var match = this.match(/[^0-9a-zA-Z\s]/gm);
            return (match === null);
        },

        /**
         * Return true if input string is upper case
         * @returns {boolean}
         */
        isUpper: function() {
            var match = this.match(/[^A-Z]/gm);
            return (match === null);
        },

        /**
         * Return true if input string is lower case
         * @returns {boolean}
         */
        isLower: function() {
            var match = this.match(/[^a-z]/gm);
            return (match === null);
        },

        /**
         * Return the byte size of the string
         * @returns {Number}
         */
        byteSize: function() {
            var len = this.length,
                size = len;

            for (var cx = 0; cx < len; cx++) {
                if (this.charCodeAt(cx) > 255)
                    size += 2;
            }

            return size;
        },

        /**
         * Format the string with additional arguments <br><br>
         *
         * write formatting position with the zero-based ordered number surrounded with braces ({0}, {1},.. {n}) <br>
         * "target string {0}, {1}".format("tes1", "test2") <br>
         * => "target string test1, test2"
         *
         * @param {string|number|boolean}
         * @returns {string} formatted string
         */
        format: function() {
            var formatted = this;

            for(var ax = 0, alen = arguments.length; ax < alen; ax++) {
                formatted = formatted.replace( '{'+ ax + '}', ""+arguments[ax] );
            }

            return formatted;
        }

    });

    // support browser compatibility for string
    var _string_proto_comp = {
        /*
         * Remove whitespace from both ends of the string
         * @returns {string} return new string stripped the whitespace
         */
        trim: function() {
            return this.replace(/^\s+|\s+$/gm, '');
        }
    }

    A.extendif( Array.prototype, _string_proto_comp, "OE" );


})(STRING);