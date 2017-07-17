class UrlParser


	def initialize(new_url) 
		@new_url = new_url
		@scheme_array = @new_url.split("://")
		
		@domain_array = @scheme_array[1].split(":")
		
		@port_array = @domain_array[1].split("/")
		
		@path_array = @port_array[1].split("?")
		
		@query_hash = Hash[*@path_array[1].split("#")[0].split(/[\s=&]/)]
		
		@fragment_id = @path_array[1].split("#")[1]
		
	end 

	def scheme
		@scheme_array[0]
	end

	def domain
		@domain_array[0]
	end

	def port
		if scheme_array[1].include? ":"
			return @port_array[0]
		else
			if @scheme_array[0].include? "s"
				return "443"
			else
				return "80"
			end
					
		end
	end

	def path
		@path_array[0]
	end

	def query_string
		@query_hash
	end

	def fragment_id
		@fragment_id
	end

end