<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:xlink= "http://www.w3.org/1999/xlink"
		xmlns:svg="http://www.w3.org/2000/svg"
		xmlns="http://www.w3.org/2000/svg">

  <xsl:template match="/resume">
    <svg version="1.1"
	 baseProfile="full"
	 width="2490" height="3510"
	 xmlns="http://www.w3.org/2000/svg"
	 xmlns:xlink= "http://www.w3.org/1999/xlink">
      <defs>
	<style type="text/css"><![CDATA[
	@font-face {
	font-family: "Lemon/Milk";
	src: url("LemonMilk.otf");
	font-weight: normal;
	font-style: normal;
	}
	
	@font-face {
	font-family: "Bitstream Vera Sans Mono";
	src: url("VeraMono.ttf");
	font-weight: normal;
	font-style: normal;
	}

	text {
	font-family: "Bitstream Vera Sans Mono";
	font-size: 36px;
	}
	
	#name-title {
	font-family: "Lemon/Milk";
	font-size: 140px;	       
	}
	
	#experience-title {
	font-family: "Lemon/Milk";
	font-size: 80px;
	}
	
	.experience-field {
	fill: #696969;
	font-size:48pt;
	}
	
	.section-title {
	font-family: "Lemon/Milk";
	font-size: 54px;
	}
	
	.general-field {
	}
	]]></style>
      </defs>
      <xsl:apply-templates select="general|education|jobs" />      
    </svg>
  </xsl:template>

  <xsl:template match="general">
    <!-- HEADER -->
    <text id="name-title" x="50%" y="240" text-anchor="middle" ><xsl:value-of select="name" /></text>
    <line  x1="5%" y1="5%" x2="25%" y2="5%" stroke="black" stroke-width="10px" />
    <line  x1="75%" y1="5%" x2="95%" y2="5%" stroke="black" stroke-width="10px" />

    <!-- GENERAL -->
    <image x="5%" y="10%" width="2%" height="2%" xlink:href="info21.svg" />
    <line x1="5%" y1="12%" x2="45%" y2="12%" stroke="black" stroke-width="6px" />
    <text class="section-title" x="8%" y="11.5%">Personal Details</text>
    
    <!-- GENERAL LIST -->
    <xsl:variable name="fieldXOffset" select="0.18" />
    <xsl:variable name="valueXOffset" select="0.19" />
    <xsl:variable name="startYOffset" select="0.135" />
    <xsl:for-each select="descendant::*[not(count(*))]">
      <text class="general-field">
	<xsl:attribute name="x"><xsl:value-of select="format-number($fieldXOffset, '0.00%')" /></xsl:attribute>
	<xsl:attribute name="y"><xsl:value-of select="format-number($startYOffset + ( position() - 1 ) * 0.015, '0.00%')" /></xsl:attribute>
	<tspan fill="#696969" text-anchor="end"><xsl:value-of select="name()" /></tspan>
	<tspan>
	  <xsl:attribute name="x"><xsl:value-of select="format-number($valueXOffset, '0.00%')"/></xsl:attribute>
	  <xsl:value-of select="." />
	</tspan>
      </text>
      <!-- <text class="general-field" x="18%" y="13.5%"><tspan fill="#696969" text-anchor="end">email</tspan><tspan x="19%" ><xsl:value-of select="email" /></tspan></text>
      <text class="general-field" x="18%" y="15%"><tspan fill="#696969" text-anchor="end">location</tspan><tspan x="19%" ><xsl:value-of select="location" /></tspan></text>
      <text class="general-field" x="18%" y="16.6%"><tspan fill="#696969" text-anchor="end">phone nr</tspan><tspan x="19%" ><xsl:value-of select="phone-number/mobile" /></tspan></text>
      <text class="general-field" x="18%" y="18%"><tspan fill="#696969" text-anchor="end">nationality</tspan><tspan x="19%"><xsl:value-of select="nationality" /></tspan></text> -->
    </xsl:for-each>

  </xsl:template>

  <xsl:template match="education">
    <!-- EDUCATION -->
    <image x="50%" y="10%" width="2%" height="2%" xlink:href="books30.svg" />
    <line x1="50%" y1="12%" x2="95%" y2="12%" stroke="black" stroke-width="6px" />
    <text class="section-title" x="53%" y="11.5%">Education</text>

    <xsl:variable name="schoolYOffset" select="xs:decimal(0.135)" />
    <xsl:variable name="infoYOffset" select="xs:decimal(0.15)" />
    <xsl:variable name="schoolXOffset" select="xs:decimal(0.52)" />
    <xsl:variable name="infoXOffset" select="xs:decimal(0.54)" />
    <xsl:variable name="yIncrement" select="xs:decimal(0.03)" />
    <xsl:for-each select="education-entry">
      <!-- EDUCATION LIST -->
      <text class="education-field" font-weight="bold">
	<xsl:attribute name="x"><xsl:value-of select="format-number($schoolXOffset, '0.00%')" /></xsl:attribute>
	<xsl:attribute name="y"><xsl:value-of select="format-number($schoolYOffset + ( ( position() - 1 ) * $yIncrement ), '0.00%')" /></xsl:attribute>
	<xsl:value-of select="major" />
      </text>
      <text class="education-field">
	<xsl:attribute name="x"><xsl:value-of select="format-number($infoXOffset, '0.00%')" /></xsl:attribute>
	<xsl:attribute name="y"><xsl:value-of select="format-number($infoYOffset + ( ( position() - 1 ) * $yIncrement ), '0.00%')" /></xsl:attribute>
	<xsl:value-of select="concat(school, ', ', @start, '-', @end)" />
      </text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="jobs">
    <xsl:variable name="educationHeight" select="count(//education/*) * 0.03 + 0.135" />
    <xsl:variable name="generalHeight" select="count(//general/*[not(count(*))]) * 0.015 + 0.135" />
    <xsl:variable name="minYOffset" select="max(($educationHeight, $generalHeight)) + 0.025" />

    <image x="5%" width="4%" height="4%" xlink:href="man379.svg" >
      <xsl:attribute name="y"><xsl:value-of select="format-number($minYOffset, '0.00%')" /></xsl:attribute>
    </image>
    <line x1="5%" x2="95%" stroke="black" stroke-width="8px" >
      <xsl:attribute name="y1"><xsl:value-of select="format-number($minYOffset+0.04, '0.00%')" /></xsl:attribute>
      <xsl:attribute name="y2"><xsl:value-of select="format-number($minYOffset+0.04, '0.00%')" /></xsl:attribute>
    </line>
    <text id="experience-title" x="10%" y="format-number($minYOffset+0.03, '0.00%')">
      <xsl:attribute name="y"><xsl:value-of select="format-number($minYOffset+0.03, '0.00%')" /></xsl:attribute>
      Experience
    </text>

    <xsl:call-template name="job-loop" >
      <xsl:with-param name="jobs" select="//job" />
      <xsl:with-param name="yOffset" select="$minYOffset + 0.04 + 0.03"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template name="job-loop">
    <xsl:param name="jobs" />
    <xsl:param name="yOffset" as="xs:decimal" />
    
    <xsl:if test="count($jobs) > 0" >
      <xsl:variable name="job" select="$jobs[1]" />
      <text class="experience-field" x="8%">
	<xsl:attribute name="y"><xsl:value-of select="format-number($yOffset, '0.00%')" /></xsl:attribute>
	<tspan font-weight="bold"><xsl:value-of select="$job/position" /></tspan><xsl:value-of select="concat(' at ', $job/company)" />
      </text>
      <text x="91%" y="31%" text-anchor="end">
	<xsl:attribute name="y"><xsl:value-of select="format-number($yOffset, '0.00%')" /></xsl:attribute>
	<xsl:value-of select="$job/location" />
      </text>
      <image x="92%" y="29%" width="3%" height="3%" xlink:href="location50.svg" />
       
      <xsl:variable name="splitLines" select="tokenize($job/description, '\n')" />
      <xsl:variable name="descrLines" select="for $line in $splitLines
					      return if(string-length($line) > 100)
					          then (normalize-space(substring($line, 1, max(index-of(string-to-codepoints(substring($line, 1, 100)), 32)))), 
						  normalize-space(substring($line, max(index-of(string-to-codepoints(substring($line, 1, 100)), 32)) + 1)))
					          else normalize-space($line)" />
      <text class="experience-desc" x="8%">
	<xsl:attribute name="y"><xsl:value-of select="format-number($yOffset+0.02, '0.00%')" /></xsl:attribute>
	<xsl:for-each select="$descrLines" >
	  <tspan>
	    <xsl:attribute name="x"><xsl:value-of select="format-number(0.08, '0.00%')" /></xsl:attribute>
	    <xsl:if test="position() > 1">
	      <xsl:attribute name="dy"><xsl:value-of select="format-number(0.015, '0.00%')" /></xsl:attribute>
	    </xsl:if>
	    <xsl:value-of select="." />
	  </tspan>
	</xsl:for-each>
      </text>
      
      <xsl:variable name="bubbleX" select="0.08" />
      <xsl:variable name="bubbleY" select="$yOffset + count($descrLines) * 0.015" />
      <xsl:variable name="languages" select="//language-entry[@id = tokenize($job/technology/@languages, ',')]" />
      <xsl:variable name="frameworks" select="//framework-entry[@id = tokenize($job/technology/@frameworks, ',')]" />
      <xsl:variable name="others" select="//other-entry[@id = tokenize($job/technology/@others, ',')]" />
      <xsl:variable name="software" select="//software-entry[@id = tokenize($job/technology/@software, ',')]" />
      <xsl:variable name="all" select="($languages, $frameworks, $others, $software)" />

      <xsl:call-template name="tag-loop">
	<xsl:with-param name="tags" select="$all" />
	<xsl:with-param name="index" select="1" />
	<xsl:with-param name="xOffset" select="$bubbleX" />
	<xsl:with-param name="yOffset" select="$bubbleY" />
      </xsl:call-template>
      <!-- <xsl:for-each select="$all"> -->
      <!-- 	<xsl:variable name="currentPos" select="position()" /> -->
      <!-- 	<xsl:variable name="absoluteXOff" select="$bubbleX + string-length(string-join($all[position() &lt; $currentPos], '')) * 0.01 + 0.03 * ($currentPos - 1)" /> -->
      <!-- 	<xsl:variable name="width" select="string-length(.) * 0.01 + 0.02" /> -->
      <!-- 	<xsl:variable name="mult" select="(absoluteXOff + $width) mod 100" /> -->
      <!-- 	<xsl:variable name="currYOff" select="($mult * 0.03) + $bubbleY" /> -->
      <!-- 	<xsl:variable name="currXOff" select="" /> -->
	
      <!-- 	<rect height="2%" fill="#7ACCC8" > -->
      <!-- 	  <xsl:attribute name="x"><xsl:value-of select="format-number($currXOff, '0.00%')" /></xsl:attribute> -->
      <!-- 	  <xsl:attribute name="y"><xsl:value-of select="format-number($currYOff, '0.00%')" /></xsl:attribute> -->
      <!-- 	  <xsl:attribute name="width"><xsl:value-of select="format-number($width, '0.00%')" /></xsl:attribute> -->
      <!-- 	  <xsl:attribute name="fill"> -->
      <!-- 	    <xsl:choose> -->
      <!-- 	      <xsl:when test=". = $languages">#7ACCC8</xsl:when> -->
      <!-- 	      <xsl:when test=". = $frameworks">#A3D39C</xsl:when> -->
      <!-- 	      <xsl:when test=". = $others">#E45F56</xsl:when> -->
      <!-- 	      <xsl:when test=". = $software">#4AAAA5</xsl:when> -->
      <!-- 	    </xsl:choose> -->
      <!-- 	  </xsl:attribute> -->
      <!-- 	</rect> -->
      <!-- 	<text fill="black" stroke="#696969" text-anchor="middle"> -->
      <!-- 	  <xsl:attribute name="x"><xsl:value-of select="format-number($currXOff + $width * 0.5, '0.00%')" /></xsl:attribute> -->
      <!-- 	  <xsl:attribute name="y"><xsl:value-of select="format-number($currYOff + 0.015, '0.00%')" /></xsl:attribute> -->
      <!-- 	  <xsl:value-of select="." /> -->
      <!-- 	</text> -->
      <!-- </xsl:for-each> -->
      <xsl:call-template name="job-loop" >
	<xsl:with-param name="jobs" select="$jobs[position() > 1]" />
	<xsl:with-param name="yOffset" select="$yOffset + 0.02 + count($descrLines) * 0.015 + ((string-length(string-join($all, ' ')) div 100) + 1) * 0.03 + 0.015 + 0.02"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="tag-loop">
    <xsl:param name="tags" />
    <xsl:param name="index" as="xs:integer" />
    <xsl:param name="xOffset" as="xs:decimal" />
    <xsl:param name="yOffset" as="xs:decimal" />
    
    <xsl:variable name="width" select="string-length($tags[$index]) * 0.01 + 0.02" />
    <xsl:variable name="currXOff" select="if($xOffset+$width > 1)
					    then 0.08
					    else $xOffset" />
    <xsl:variable name="currYOff" select="if($xOffset+$width > 1)
					    then $yOffset + 0.03
					    else $yOffset" />
    
    <rect height="2%" fill="#7ACCC8" >
      <xsl:attribute name="x"><xsl:value-of select="format-number($currXOff, '0.00%')" /></xsl:attribute>
      <xsl:attribute name="y"><xsl:value-of select="format-number($currYOff, '0.00%')" /></xsl:attribute>
      <xsl:attribute name="width"><xsl:value-of select="format-number($width, '0.00%')" /></xsl:attribute>
      <xsl:attribute name="fill">
	<xsl:choose>
	  <xsl:when test="$tags[$index] = //language-entry/text()">#7ACCC8</xsl:when>
	  <xsl:when test="$tags[$index] = //framework-entry">#A3D39C</xsl:when>
	  <xsl:when test="$tags[$index] = //other-entry">#E45F56</xsl:when>
	  <xsl:when test="$tags[$index] = //software-entry">#4AAAA5</xsl:when>
	  <xsl:otherwise>#00FF00</xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
    </rect>
    <text fill="black" stroke="#696969" text-anchor="middle">
      <xsl:attribute name="x"><xsl:value-of select="format-number($currXOff + $width * 0.5, '0.00%')" /></xsl:attribute>
      <xsl:attribute name="y"><xsl:value-of select="format-number($currYOff + 0.015, '0.00%')" /></xsl:attribute>
      <xsl:value-of select="$tags[$index]" />
    </text>

    <xsl:choose>
      <xsl:when test="$index &lt; count($tags)">
	<xsl:call-template name="tag-loop">
	  <xsl:with-param name="tags" select="$tags" />
	  <xsl:with-param name="index" select="$index+1" />
	  <xsl:with-param name="xOffset" select="$currXOff + $width + 0.02" />
	  <xsl:with-param name="yOffset" select="$currYOff" />
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$currYOff" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
