puts "This program will find the zscore, mean, median and standard deviation of a set of data"
f= File.open("google.csv", "r+")
info= f.readlines

#split stocks at the comma
i = 0
while i <  info.length
	info[i] = info[i].split(",")
	i= i+1
end

#mean
i=0
sum=0
while i < info.length
	sum=info[i][1].tr('"','').to_f + sum
	i=i+1
end
mean= sum/info.length
puts "Your mean is #{ mean.round(2)} "

#standard deviation
i=0
sum1=0
while i < info.length
	sum1=(info[i][1].tr('"','').to_f - mean)**2 + sum1
	i= i + 1
end 
dev= Math.sqrt(sum1/(info.length-1))
puts "Your standard deviation is #{dev.round(2)}"

#median
middlenum=0
median=0
middlenum=info.length/2
median= info[middlenum][1]
puts "Your median is #{median}"


#zscore, and write every stock price with all stats

fNew=File.open("stockStats.csv", "a+")

i=0
zScore=0
while i < info.length
	zScore = (info[i][1].tr('"','').to_f- mean)/dev
	fNew.write(info[i][0].tr('"','').to_f)
	fNew.write("      ")
	fNew.write(info[i][1].tr('"','').to_f)
	fNew.write("      ")
	fNew.write(zScore) 
	fNew.write("      ")
	fNew.write(dev)
	fNew.write("      ")
	fNew.write(mean)
	fNew.write("\n")
	i= i+1
end

f.close
fNew.close
puts "Your data has been exported to a file called 'stockStats.csv'"
