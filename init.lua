wifi.setmode(wifi.STATION)
wifi.sta.config("TheSSID","TheSecret")
print(wifi.sta.getip())
D0 = 0
D1 = 1
D2 = 2

gpio.mode(D0, gpio.OUTPUT)
gpio.mode(D1, gpio.OUTPUT)
gpio.mode(D2, gpio.OUTPUT)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end

        buf = buf.."<!DOCTYPE html>";
        buf = buf.."<html>";
        buf = buf.."<head>";
        buf = buf.."<title>ESP8266 WebServer by a.Cincarevic</title>";
        buf = buf.."</head>";
        buf = buf.."<body>";
        buf = buf.."<center><h1 class='badge'>NodeMCU/ESP8266 UI</b></h1></center>";
        buf = buf.."<div class='container'>";
        buf = buf.."<p class='badge'>nr 1</p><input type='button' class='btn btn-success' value='ON' onclick='ledOn(0)'><input type='button' class='btn btn-danger' value='OFF' onclick='ledOff(0)'><br>";
        buf = buf.."<p class='badge'>nr 2</p><input type='button' class='btn btn-success' value='ON' onclick='ledOn(1)'><input type='button' class='btn btn-danger' value='OFF' onclick='ledOff(1)'><br>";
        buf = buf.."</div>";
        buf = buf.."<script> alert(\"Esp8266 Webserver\")</script>";
        buf = buf.."</body>";
        buf = buf.."</html>";
        
        local _on,_off = "",""
        if(_GET.pin == "ON0")then
              gpio.write(D0, gpio.HIGH);
        elseif(_GET.pin == "OFF0")then
              gpio.write(D0, gpio.LOW);
              
        elseif(_GET.pin == "ON1")then
              gpio.write(D1, gpio.HIGH);
        elseif(_GET.pin == "OFF1")then
              gpio.write(D1, gpio.LOW);
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)