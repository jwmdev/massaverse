/***
 * Excerpted from "Dart 1 for Everyone",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/csdart1 for more book information.
***/
function Person(name) {
    this.name = name;
    this.greet = function() {
      return 'Howdy, ' + this.name + '!';
    };
  }
  