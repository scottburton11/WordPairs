module SampleDictionary # :nodoc:
  def dictionary
<<-EOF
burgeon\r\nburgeoned\r\nburgeoning\r\nburgeons\r\nburger\r\nburgers\r\nburgess\r\nburgesses\r\nburgh\r\nburgher\r\nburghers\r\nburghs\r\nburglar\r\nburglaries\r\nburglarious\r\nburglariously\r\nburglarise\r\nburglarize\r\nburglarized\r\nburglarizes\r\nburglarizing\r\nburglarproof\r\nburglars\r\nburglary\r\nburgle\r\nburgled\r\nburgles\r\nburgling\r\nburgomaster\r\nburgomasters\r\nburgoo\r\nburgoos\r\nburgouts\r\nburgs\r\nburgundies\r\nburgundy\r\nburial
EOF
  end
  
  def words
    dictionary.scan(/\b\w+\b/)
  end
  
end