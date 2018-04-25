

//==========================================================================================================//
//= Data Load                                                                                              =//
//==========================================================================================================//

  var data = {
    "nodes":[
            {"node":"A1", "level":4, "position":1, "edge":"A1B2"},
            {"node":"A2", "level":4, "position":9, "edge":"A2B1"},
            {"node":"B1", "level":4, "position":10, "edge":"A2B1"},
            {"node":"B2", "level":4, "position":2, "edge":"A1B2"},
            {"node":"C1", "level":4, "position":3, "edge":"C1D2"},
            {"node":"C2", "level":4, "position":11, "edge":"C2D1"},
            {"node":"D1", "level":4, "position":12, "edge":"C2D1"},
            {"node":"D2", "level":4, "position":4, "edge":"C1D2"},
            {"node":"E1", "level":4, "position":13, "edge":"E1F2"},
            {"node":"E2", "level":4, "position":5, "edge":"E2F1"},
            {"node":"F1", "level":4, "position":6, "edge":"E2F1"},
            {"node":"F2", "level":4, "position":14, "edge":"E1F2"},
            {"node":"G1", "level":4, "position":15, "edge":"G1H2"},
            {"node":"G2", "level":4, "position":7, "edge":"G2H1"},
            {"node":"H1", "level":4, "position":8, "edge":"G2H1"},
            {"node":"H2", "level":4, "position":16, "edge":"G1H2"},
            {"node":"A1B2", "level":3, "position":1, "edge":"A1B2C1D2"},
            {"node":"C1D2", "level":3, "position":2, "edge":"A1B2C1D2"},
            {"node":"E1F2", "level":3, "position":7, "edge":"E1F2G1H2"},
            {"node":"G1H2", "level":3, "position":8, "edge":"E1F2G1H2"},
            {"node":"A2B1", "level":3, "position":5, "edge":"A2B1C2D1"},
            {"node":"C2D1", "level":3, "position":6, "edge":"A2B1C2D1"},
            {"node":"E2F1", "level":3, "position":3, "edge":"E2F1G2H1"},
            {"node":"G2H1", "level":3, "position":4, "edge":"E2F1G2H1"},
            {"node":"A1B2C1D2", "level":2, "position":1, "edge":"A1B2C1D2E1F2G1H2"},
            {"node":"A2B1C2D1", "level":2, "position":3, "edge":"A2B1C2D1E2F1G2H1"},
            {"node":"E1F2G1H2", "level":2, "position":4, "edge":"A1B2C1D2E1F2G1H2"},
            {"node":"E2F1G2H1", "level":2, "position":2, "edge":"A2B1C2D1E2F1G2H1"},
            {"node":"A1B2C1D2E1F2G1H2", "level":1, "position":1, "edge":"final"},
            {"node":"A2B1C2D1E2F1G2H1", "level":1, "position":2, "edge":"final"},
            {"node":"final", "level":0, "position":1, "edge":""},
    ],
    "groups": [
            {"label":"2nd of H","group":"H","node":"H2","position":16,"team":"Poland","nodes":[{"node":"H2", "status":""},{"node":"G1H2", "status":"Lost"},]}, 
            {"label":"1st of G","group":"G","node":"G1","position":15,"team":"Belgium","nodes":[{"node":"G1", "status":""},{"node":"A1B2C1D2E1F2G1H2", "status":"Lost"},{"node":"E1F2G1H2", "status":"Win"},{"node":"G1H2", "status":"Win"},]}, 
            {"label":"2nd of F","group":"F","node":"F2","position":14,"team":"Sweden","nodes":[{"node":"F2", "status":""},{"node":"E1F2", "status":"Lost"},]}, 
            {"label":"1st of E","group":"E","node":"E1","position":13,"team":"Brazil","nodes":[{"node":"E1", "status":""},{"node":"E1F2", "status":"Win"},{"node":"E1F2G1H2", "status":"Lost"},]}, 
            {"label":"1st of D","group":"D","node":"D1","position":12,"team":"Argentina","nodes":[{"node":"D1", "status":""},{"node":"A2B1C2D1", "status":"Lost"},{"node":"C2D1", "status":"Win"},]}, 
            {"label":"2nd of C","group":"C","node":"C2","position":11,"team":"Denmark","nodes":[{"node":"C2", "status":""},{"node":"C2D1", "status":"Lost"},]}, 
            {"label":"1st of B","group":"B","node":"B1","position":10,"team":"Portugal","nodes":[{"node":"B1", "status":""},{"node":"A2B1C2D1E2F1G2H1", "status":"Win"},{"node":"A2B1C2D1", "status":"Win"},{"node":"A2B1", "status":"Win"},{"node":"final", "status":"Lost"},]}, 
            {"label":"2nd of A","group":"A","node":"A2","position":9,"team":"Russia","nodes":[{"node":"A2", "status":""},{"node":"A2B1", "status":"Lost"},]}, 
            {"label":"1st of H","group":"H","node":"H1","position":8,"team":"Colombia","nodes":[{"node":"H1", "status":""},{"node":"E2F1G2H1", "status":"Lost"},{"node":"G2H1", "status":"Win"},]}, 
            {"label":"2nd of G","group":"G","node":"G2","position":7,"team":"England","nodes":[{"node":"G2", "status":""},{"node":"G2H1", "status":"Lost"},]}, 
            {"label":"1st of F","group":"F","node":"F1","position":6,"team":"Germany","nodes":[{"node":"F1", "status":""},{"node":"A2B1C2D1E2F1G2H1", "status":"Lost"},{"node":"E2F1G2H1", "status":"Win"},{"node":"E2F1", "status":"Win"},]}, 
            {"label":"2nd of E","group":"E","node":"E2","position":5,"team":"Switzerland","nodes":[{"node":"E2", "status":""},{"node":"E2F1", "status":"Lost"},]}, 
            {"label":"2nd of D","group":"D","node":"D2","position":4,"team":"Croatia","nodes":[{"node":"D2", "status":""},{"node":"C1D2", "status":"Lost"},]},
            {"label":"1st of C","group":"C","node":"C1","position":3,"team":"France","nodes":[{"node":"A1B2C1D2E1F2G1H2", "status":"Win"},{"node":"A1B2C1D2", "status":"Win"},{"node":"final", "status":"Win"},{"node":"C1D2", "status":"Win"},{"node":"C1", "status":""},]}, 
            {"label":"2nd of B","group":"B","node":"B2","position":2,"team":"Spain","nodes":[{"node":"B2", "status":""},{"node":"A1B2C1D2", "status":"Lost"},{"node":"A1B2", "status":"Win"},]}, 
            {"label":"1st of A","group":"A","node":"A1","position":1,"team":"Uruguay","nodes":[{"node":"A1", "status":""},{"node":"A1B2", "status":"Lost"},]}, 
      ]
  }

//==========================================================================================================//
//= Setup                                                                                                  =//
//==========================================================================================================//

  var margin = {top: 15, right: 10, bottom: 5, left: 0},
      width = 750 - margin.left - margin.right,
      height = 750 - margin.top - margin.bottom;
  //    height = 533 - margin.top - margin.bottom;

  var color = {"background": "#444",
              "circleHome": "#9ECCFF",
              "circleAway": "#B96359",
              "circleNeutral": "white",
              "axis": "#eee",
              "text": "#fff",
              "line": "#888",
              "black": "#000000",
              "groupGray": {"A": "#333", "B": "#666", "C": "#555", "D": "#888", "E": "#777", "F": "#AAA", "G": "#999", "H": "#CCC"}, //grayscale
              "group": {"A": "#2A3A85", "B": "#FCD412", "C": "#61AA25", "D": "#DB2624", "E": "#0193D9", "F": "#F09D0C", "G": "#09621D", "H": "#86001A"}}; // Fifa Colors


// CIRCLE GRAPH
  var widthCircle = width
  var heightCircle = height
  var cxCircle = widthCircle/2
  var cyCircle = heightCircle/2
  var levelsCircle = 6
  var rLevel = (cxCircle)/(levelsCircle)
  var radius = cxCircle

  var nodeAttr = {"fill": color.circleNeutral,
                  "stroke": color.line,
                  "r": 7,
                  "stroke-width": "3px",
                  "opacity": 1}

  var nodeHighlight = {"fill": "#7273B0",
                      "stroke": "black",
                      "stroke-width": "3px",
                      "r": 30}

  var probAttr = {"font-size": "18px",
                "font-style": "normal", 
                "font-weight": "bold",
                "fill": "white",
                "text-anchor": "middle",
                "vertical-align": "middle",
                "display": "none"}

  var probHighlight = {"display": "inline"}

                /*d3.select(this).attr("fill", function(d, i) {return color.circleNeutral});
                d3.select(this).attr("stroke", function(d, i) {return color.line});
                d3.select(this).attr("r", nodeRadius);*/

  var linkAttr = {"stroke": color.line,
                  "stroke-width": "2px",
                  "fill": "none"}

  var linkHighlight = {"stroke": "#1659F5",
                  "stroke-width": "4px",
                  "fill": "none"}

  var posAdjust = 20;

  var colorScale = d3.scale.linear()
  .domain([1, 0.2, 0]) // values elevation (m)
  .range(["#ccc", "#aaa", "#333"]) // green to red
//  .range(["red", "#C3C959", "#97F597"]) // green to red
//  .range(["#A6ABDF", "#474159"]) // colors
  .interpolate(d3.interpolateHcl)



// FRAME
  var svg = d3.select("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  svg.append("rect")
      .attr({
          "x": -margin.left,
          "y": -margin.top,
          "width": width + margin.left + margin.right,
          "height": height + margin.top + margin.bottom,
          "stroke": color.line,
          "stroke-width": .5,
          "fill": "#ffffff",
          "opacity": 1
      })


//==========================================================================================================//
//============================================= CIRCULAR ===================================================
//=============================================  GRAPH   ===================================================
//==========================================================================================================//


    //==========================================================================================================//
    //= Calculate nodes positions and rotation                                                                 =//
    //==========================================================================================================//

      var nodePosition = {}

      for (i in data.nodes) {
          node = data.nodes[i]
          if (node.level == 4) rotation = - 22.5 * node.position + 11.25;
          else if (node.level == 3) rotation = - 45 * node.position + 22.5;
          else if (node.level == 2) rotation = - 90 * node.position + 45;
          else if (node.level == 1) rotation = 180 * node.position - 180;
          r =  rLevel * node.level
          x = cxCircle + Math.sin(rotation * Math.PI / 180) * r
          y = cyCircle - Math.cos(rotation * Math.PI / 180) * r
          nodePosition[node.node] = {'x': x, 'y': y, 'r': r, 'rotation': rotation}
      }

    //==========================================================================================================//
    //= Groups                                                                                                  =//
    //==========================================================================================================//

      var gGroups = svg.append("g")
              .attr("id", "groups")

      var arcBox = d3.svg.arc()
          .outerRadius(radius)
          .innerRadius(radius - 2* rLevel);

      var pie = d3.layout.pie()
          .sort(null)
          .value(function(d) { return 1; });

      var gGroupsBox = gGroups.selectAll(".arc")
          .data(pie(data.groups))
          .enter().append("g")
          .attr({
            "class": "arc",		
            "transform": "translate(" + cxCircle + ", " + cyCircle + ")"});

      gGroupsBox.append("path")
          .attr({
            "d": arcBox,
            "fill": function(d) {return color.group[d.data.group]; },
            "opacity": .08,
            "stroke": "black",
            "stroke-width": "1px",
            "stroke-opacity": 10});

      // ARC BORDER - Transparency of 1st Arc makes borders transparent also
      gGroupsBox.append("path")
          .attr({
            "d": arcBox,
            //"fill": function(d) { return "#eee"; },
            "fill": "none",
            "opacity": 1,
            "stroke": color.line,
            "stroke-width": "1px",
            "stroke-opacity": 1});
	

      // INNER and OUTER RINGS
      var arcInner = d3.svg.arc()
          .outerRadius(radius - 2* rLevel + rLevel/3)
          .innerRadius(radius - 2* rLevel);

      var gRings = gGroups.selectAll(".arcInner")
          .data(pie(data.groups))
          .enter().append("g")
          .attr({
            "class": "arcInner",
            "transform": "translate(" + cxCircle + ", " + cyCircle + ")"});

      gRings.append("path")
          .attr({
            "id": function(d) {return d.data.node},
            "class": function(d) {return d.data.group},
            "d": arcInner,
            "fill": function(d) {return color.gray; },
            //"fill": function(d) {return color.groupGray[d.data.group]; },
            "opacity": 1,
            "stroke": color.line,
            "stroke-width": "1px"});
			
	
      var arcOuterRing = d3.svg.arc()
          .outerRadius(radius)
          .innerRadius(radius - 5);

      gRings.append("path")
          .attr({
            "id": function(d) {return d.data.node},
            "class": function(d) {return d.data.group},
            "d": arcOuterRing,
            "fill": function(d) {return color.gray; },
            //"fill": function(d) {return color.groupGray[d.data.group]; },
            "opacity": 1,
            "stroke": color.line,
            "stroke-width": "1px"});


      // LABELS
      var gLabel = gGroups.selectAll(".arcLabel")
          .data(data.groups)
          .enter().append("g")
          .attr({
            "class": "arcLabel"});

      gLabel.append("text")
          .attr({
            "x": function(d) { return cxCircle; },
            "y": function(d) { 
                              rotation = nodePosition[d.node].rotation;
                              console.log(rotation)
                              console.log(d)
                              if (-270 < rotation && rotation < -90) return cyCircle + rLevel * 4 + rLevel/4
                              else return cyCircle - rLevel * 4 - rLevel/16},
            //"x": 10,
            //"y": 10,
            "font-size": "20px",
            "font-style": "normal", 
            "font-weight": "bold",
            "fill": function(d) { return "white"; },
            "text-anchor": "middle",
            "transform": function(d, i) {
                              rotation = nodePosition[d.node].rotation;
                              if (-270 < rotation && rotation < -90) rotation = rotation + 180;
                              return "rotate(" + rotation + " " + cxCircle + " " + cyCircle + ")";}
          })
          .text(function(d) { return d.label; });


    //==========================================================================================================//
    //= Teams                                                                                                  =//
    //==========================================================================================================//

		  
		var gTeam = gGroups.selectAll(".team")
          .data(data.groups)
          .enter().append("g")
          .attr({
            "class": "team"});

      gTeam.append("text")
          .attr({
			"id": function(d) { return d.team},
            "x": function(d) { return cxCircle ; },
            "y": function(d) { 
                              rotation = nodePosition[d.node].rotation;
                              console.log(rotation)
                              console.log(d)
                              if (-270 < rotation && rotation < -90) return cyCircle + rLevel * 5 + rLevel/4
                              else return cyCircle - rLevel * 5 - rLevel/16},
            //"x": 10,
            //"y": 10,
            "font-size": "20px",
            "font-style": "normal", 
            "font-weight": "bold",
            "fill": function(d) { return "white"; },
            "text-anchor": "middle",
            "transform": function(d, i) {
                              rotation = nodePosition[d.node].rotation;
                              if (-270 < rotation && rotation < -90) rotation = rotation + 180;
                              return "rotate(" + rotation + " " + cxCircle + " " + cyCircle + ")";}
          })
          .text(function(d) { return d.team; })
		  .on("mouseover", function(d){
                    d.nodes.forEach(function (d, i) {

                                      node = gNodes.select("circle#" + d.node)
									  if (d.status != "" ){
										node.transition().delay(0).duration(100)
                                          .attr(nodeHighlight)
                                          .attr('fill',color.gray);
									  Match = gNodes.select("text#" + d.node)
                                      Match.attr(probHighlight);
                                      Match.text(d.status)                                      
									  }
									  if (d.status == "Win" || d.status == "" ){									  
                                      edge = gLinks.select("path.link#" + d.node)
                                      edge.attr(linkHighlight)
									  }
									  })
					d3.select("#" + d.team).attr({"fill": "#1659F5"})       
					gRings.selectAll("#" + d.node).attr("fill", color.group[d.group])      
                    })
              .on("mouseout", function(d){
                    d.nodes.forEach(function (d, i) {
                                      node = gNodes.select("#" + d.node)
                                      node.transition().delay(100).duration(100).attr(nodeAttr)
                                      prob = gNodes.select("text#" + d.node)
                                      prob.attr(probAttr);
                                      edge = gLinks.select("path#" + d.node)
                                      edge.attr(linkAttr)
                    })
                    resetCharts()
              })



    //==========================================================================================================//
    //= Edges                                                                                                  =//
    //==========================================================================================================//

      path = function(d) {
          var curvature = .3;

          origin = d.node
          destiny = d.edge
          origX = nodePosition[origin].x
          origY = nodePosition[origin].y
          origR = nodePosition[origin].r
          origRot = nodePosition[origin].rotation

          destX = nodePosition[destiny].x
          destY = nodePosition[destiny].y
          destR = nodePosition[destiny].r
          destRot = nodePosition[destiny].rotation

          var x0 = origX,
              y0 = origY,
              x1 = cxCircle + Math.sin(origRot * Math.PI / 180) * (origR - rLevel * curvature)
              y1 = cyCircle - Math.cos(origRot * Math.PI / 180) * (origR - rLevel * curvature)
              x2 = cxCircle + Math.sin(destRot * Math.PI / 180) * (destR + rLevel * curvature)
              y2 = cyCircle - Math.cos(destRot * Math.PI / 180) * (destR + rLevel * curvature)
              x3 = destX,
              y3 = destY

          return "M" + x0 + "," + y0
               + "L" + x1 + "," + y1
               + "L" + x2 + "," + y2
               + "L" + x3 + "," + y3;
      }
      
      var gLinks = svg.append("g")
              .attr("id", "link")

      var link = gLinks.selectAll(".link")
              .data(data.nodes.slice(0, data.nodes.length-1))
              .enter().append("path")
              .attr({"class": "link",
                    "id": function(d) {return d.node},
                    "d": path})
              .attr(linkAttr)


    //==========================================================================================================//
    //= Nodes                                                                                                  =//
    //==========================================================================================================//

      var gNodes = svg.append("g")
              .attr("id", "nodes")

      gNodes.selectAll(".circle")
              .data(data.nodes)
              .enter()
              .append("circle")
              .attr({
                "id": function(d) { return d.node; },
                "cx": function(d) { return cxCircle; },
                "cy": function(d) { return cyCircle - (rLevel * d.level); }})
              .attr("transform", function(d, i) { 

                                      rotation = nodePosition[d.node].rotation
                                      d.rotation = rotation
                                      return "rotate(" + rotation + " " + cxCircle + " " + cyCircle + ")"; })
				.on("mouseover", function(d){
                    d3.select(this).attr('fill', '#1659F5');
                    node = d.node;
                    
              })
              .on("mouseout", function(d){
                    d3.select(this).attr(nodeAttr)
                    resetCharts()
              })
              .transition()
              .delay(function(d, i) { return (d.level*200);})
              .duration(1000)
              .attr(nodeAttr)

      gNodes.selectAll(".status")
              .data(data.nodes)
              .enter().append("text")
              .text('100%')
              .attr({
                "id": function(d) { return d.node; },
                "x": function(d) { return nodePosition[d.node].x; },
                "y": function(d) { return nodePosition[d.node].y + 6; }})
              .attr(probAttr)

//==========================================================================================================//
//============================================  FUNCTIONS  =================================================
//==========================================================================================================//

  function resetCharts() {

      //gTeamsProb.selectAll("text").text("hello")
      gRings.selectAll("path").attr("fill", color.gray)
      gTeam.selectAll("text").attr("fill", color.text);

  }

