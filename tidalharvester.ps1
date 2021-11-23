
$file = invoke-webrequest "http://api.sehavniva.no/tideapi.php?lat=60.267297&lon=5.221699&fromtime=2021-11-23T00%3A00&totime=2022-11-24T00%3A00&datatype=tab&refcode=cd&place=&file=&lang=nn&interval=60&dst=0&tzone=&tide_request=locationdata"
$xml = [xml]$fil
$xmlobj = $xml.SelectNodes("//data/waterlevel") 
[System.Decimal]$high = 0.0
[System.Decimal]$low = 20.0 # pretty low

foreach ($n in $xmlobj)
{
    [System.Decimal]$verdi = [System.Decimal]$n.GetAttribute("value")
    $flag = $n.GetAttribute("flag")
    $time = $n.GetAttribute("time")
    if ($high -le $verdi)
    {
        $high = $verdi
        $tid = $time
        Write-Host "høyvann: $high og tid: $tid og $flag"
    }
    if ($verdi -le $low )
    {
        $low = $verdi
        $tid = $time
        Write-Host "lavvann: $low og tid: $tid og $flag"
    }
}
