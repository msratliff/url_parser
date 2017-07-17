class UrlParser

	def initialize(new_url) 
		@new_url = new_url
		
		@scheme_array = @new_url.split("://")
		
		@domain_array = 
			if @scheme_array.last.include? ":"
				@scheme_array.last.split(":")
			else
			 	@scheme_array.last.split("/")
			end
		
		@port_array = 
			if @scheme_array.last.include? ":"
				@domain_array.last.split("/").first
			else
				if @new_url.downcase.include? "https"
					"443"
				else 
					"80"
				end
			end
				
		@path_array = 
			if @scheme_array.last.include? ":"
				if @new_url.include? ("?")
					if @new_url.include? "/?"
						nil
					else
						@domain_array.last.split("?").first.split("/").drop(1).join("/")
					end
				elsif @new_url.include? ("#")
					if @new_url.include? "/#"
						nil
					else
						@domain_array.last.split("#").first.split("/").drop(1).join("/")
					end
				else
					if @domain_array.last.split("/").drop(1).join("/") == ""
						nil
					else
						@domain_array.last.split("/").drop(1).join("/")
					end
				end
			else 
				if @new_url.include? ("?")
					if @new_url.include? "/?"
						nil
					else
						@domain_array.drop(1).join("/").split("?").first
					end
				elsif @new_url.include? ("#")
					if @new_url.include? "/#"
						nil
					else
						@domain_array.drop(1).join("/").split("#").first
					end
				else
					if @domain_array.drop(1).join("/") == ""
						nil
					else
						@domain_array.drop(1).join("/")
					end
				end
			end

		
		@query_hash = 
			if new_url.include? "?"
				if new_url.include? "#"
					Hash[*new_url.split("?").last.split("#").first.split(/[\s=&]/)]
					# Hash[*@path_array[1].split("#")[0].split(/[\s=&]/)]
				else
					Hash[*new_url.split("?").last.split(/[\s=&]/)]
				end
			else
				nil
			end
		
		@fragment_id = 
			if @new_url.include? "#"
				@new_url.split("#").last
			else
				nil
			end
		
	end 
	
	def scheme
		@scheme_array.first
	end

	def domain
		@domain_array.first
	end

	def port
		@port_array
	end

	def path
		@path_array
	end

	def query_string
		@query_hash
	end

	def fragment_id	
		@fragment_id
	end

	
end