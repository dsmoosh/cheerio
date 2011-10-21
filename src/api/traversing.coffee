_ = require "underscore"
$ = require "../cheerio"

###
  Stupidly simple traversal
  
  TODO : Make it more jQuery-like
###

parent = exports.parent = (elem) ->
  return if (this[0] and this[0].parent) then $(this[0].parent) else null

next = exports.next = (elem) ->
  return null if not this[0]
  
  nextSibling = this[0].next
  while nextSibling
    return $(nextSibling) if nextSibling.type is "tag"
    nextSibling = nextSibling.next
  
  return null
  
prev = exports.prev = (elem) ->
  return null if not this[0]
  
  prevSibling = this[0].prev
  while prevSibling
    return $(prevSibling) if prevSibling.type is "tag"
    prevSibling = prevSibling.prev
    
  return null

siblings = exports.siblings = (elem) ->
  siblings = _.filter this.parent().children(), (elem) =>
    elem isnt this[0] and elem.type is "tag"
  
  return $(siblings)

children = exports.children = (elem) ->
  if this[0] and this[0].children
    children = _.filter this[0].children, (elem) => 
      elem.type is "tag"
    return children
  else
    return null

# Execute a callback for every element in the matched set.
# (You can seed the arguments with an array of args, but this is
# only used internally.)
each = exports.each = (callback, args) ->
  return $.each this, callback, args
  
# filter = exports.filter = (selector)
#   this.pushStack 


module.exports = $.fn.extend exports