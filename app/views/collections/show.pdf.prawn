pdf.text "#{@folder.company.name} | #{@folder.name} | Style #{@style.number}", :size => 20, :style => :bold

pdf.move_down(20)

pdf.text "Basic Information:", :size => 16, :style => :bold
pdf.text "Notes: #{@collection.notes}
Projected Units: #{@collection.projected_units}
Number of Colors: #{@collection.number_of_colors}
Sizing: #{@collection.size}
Modifications: #{@collection.modification}
Delivery Date: #{@collection.delivery_date}
Export Type: #{@collection.export}
Shipment Type: #{@collection.shipment}
Shipping Cost: #{@collection.ship_cost}
Price: #{@collection.pricing}"

pdf.move_down(20)

pdf.text "Pre-Production Approvals:", :size => 16, :style => :bold

pdf.text "Fit: #{@collection.fit_approval}
Date: #{@collection.fit_approval_date}
Note: #{@collection.fit_approval_note}"

pdf.move_down(10)

pdf.text "Color: #{@collection.color_approval}
Date: #{@collection.color_approval_date}
Note: #{@collection.color_approval_note}"

pdf.move_down(10)

pdf.text "Print: #{@collection.print_approval}
Date: #{@collection.print_approval_date}
Note: #{@collection.print_approval_note}"

pdf.move_down(10)

pdf.text "Quality: #{@collection.quality_approval}
Date: #{@collection.quality_approval_date}
Note: #{@collection.quality_approval_note}"

pdf.move_down(20)

pdf.text "Production:", :size => 16, :style => :bold

pdf.text "Factory Start Date: #{@collection.factory_start_date}
Estimated Exit Factory Date: #{@collection.ex_factory_date}" 

pdf.move_down(10)

pdf.text "Production Approvals:
PP: #{@collection.pp_approval}
Date: #{@collection.pp_approval_date}
Note: #{@collection.pp_approval_note}"

pdf.move_down(10)

pdf.text "TOP: #{@collection.top_approval}
Date: #{@collection.top_approval_date}
Note: #{@collection.top_approval_note}"

pdf.move_down(20)

pdf.text "Shipping Information:", :size => 16, :style => :bold

pdf.text "Vessel: #{@collection.vessel}
Voyage: #{@collection.voyage}
Tracking Number: #{@collection.tacking_number}
Estimated ETA: #{@collection.eta}"
