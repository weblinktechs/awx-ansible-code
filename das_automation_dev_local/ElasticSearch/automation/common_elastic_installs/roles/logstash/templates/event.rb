require 'date'

def register(params)
end

def filter(event)
  base_field = "[Events][Event]"
  e = event.get(base_field)

  # list of arrays to compact and their parent => child relationships
  arrays = {"[PersonProperty]" => "[Property]", "[Persons]" => "[Person]", "[Precincts]" => "[Precinct]", "[Addresses]" => "[Address]", "[PerpCharacteristics]" => "[Characteristic]", "[Weapons]" => "[Weapon]", "[EventDetails]" => "[EventDetail]", "[Officers]" => "[Officer]", "[CrimeTypes]" => "[CrimeType]", "[Vehicles]" => "[Vehicle]", "[PhoneNumbers]" => "[Phone]", "[Narratives]" => "[EventNarrative]", "[Narratives]" => "[Narrative]", "[CaseInfoList]" => "[CaseInfo]", "[Sources]" => "[Source]", "[Alerts]" => "[Alert]", "[ChargeDispositions]" => "[ChargeDisposition]", "[ChargeProceedings]" => "[ChargeProceeding]", "[Dockets]" => "[Docket]", "[Attorneys]" => "[Attorney]"}

  # compact arrays
  arrays.each do |parent, child|
    children = event.get(base_field + parent + "[0]" + child)
    event.set(base_field + parent, children) if children
  end

  # Persons cleanup
  Array(event.get(base_field + "[Persons]")).each_with_index do |p,i|
    # cover alternate formats
    begin
      p["DOB"] = DateTime.strptime(p["DOB"].strip, "%b %e %Y %I:%M%p").to_s if p["DOB"]
    rescue ArgumentError
      begin
        p["DOB"] = DateTime.strptime(p["DOB"].strip, "%FT%H:%M:%S").to_s if p["DOB"]
      rescue
      end
    end
    event.set(base_field + "[Persons][" + i.to_s + "][DOB]", p["DOB]"]) if p["DOB"]
  end

  # Event Details cleanup
  Array(event.get(base_field + "[EventDetails]")).each_with_index do |p,i|
    # cover alternate formats
    begin
      p["PERPETRATOR_DOB"] = DateTime.strptime(p["PERPETRATOR_DOB"].strip, "%m/%d/%Y").to_s if p["PERPETRATOR_DOB"]
    rescue ArgumentError
      begin
        p["PERPETRATOR_DOB"] = DateTime.strptime(p["PERPETRATOR_DOB"].strip, "%FT%H:%M:%S").to_s if p["PERPETRATOR_DOB"]
      rescue
      end
    end
    event.set(base_field + "[Persons][" + i.to_s + "][PERPETRATOR_DOB]", p["PERPETRATOR_DOB]"]) if p["PERPETRATOR_DOB"]
  end

  # cleanup
  ## sources
  begin
    sources = base_field + "[Sources]"
    source =  event.get(sources + "[0]")
    event.set(base_field + "[Source]", source)
    event.set(base_field + "[Source][SourceNameWebSafe]", source["SourceName"].gsub(" ", "-").downcase)
    event.remove(sources)
  rescue
    event.set("[Source][SourceNameWebSafe]", "error")
  end

  # Move everything up
  event.get(base_field).each do |k,v|
    event.set(k, v)
  end

  event.remove("[Events]")

  return [event]
end
