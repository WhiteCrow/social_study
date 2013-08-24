Array::last = ->
  @[@.length-1]

Array::isInclude = (obj)->
  for item in  @
    if obj is item
      return item
  false

Array::isIncludeAttr = (attrKey, attrValue)->
  for item in @
    if item[attrKey] and attrValue is item[attrKey]
      return item
  false
