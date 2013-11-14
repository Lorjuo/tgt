#$("#container").on "cocoon:after-insert", (e, insertedItem) ->
$(document).bind 'cocoon:after-insert', (e, inserted_item) -> 
  init_pickers()