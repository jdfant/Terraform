{
  "body" : $input.json('$'),
  "headers": {
    #foreach($param in $input.params().header.keySet())
    "$param": "$util.escapeJavaScript($input.params().header.get($param))" #if($foreach.hasNext),#end

    #end  
  },
  "stage" : "$context.stage"
}

#set($inputRoot = $input.path('$'))
{
  "Account": "$inputRoot.account",
  "Region": "$inputRoot.region",
  "KeyUsage": "$inputRoot.key_usage",
  "KeyAlias": "$inputRoot.key_alias",
  "KeyDescription": "$inputRoot.key_description"
}