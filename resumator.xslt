<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:xlink= "http://www.w3.org/1999/xlink"
		xmlns:svg="http://www.w3.org/2000/svg"
		xmlns="http://www.w3.org/2000/svg">

  <xsl:template match="/resume">
    <svg version="1.2"
	 baseProfile="full"
	 width="2490" height="7020"
	 viewBox="0 0 2490 7020"
	 preserveAspectRatio="xMinYMin"
	 xmlns="http://www.w3.org/2000/svg"
	 xmlns:xlink= "http://www.w3.org/1999/xlink">
      <defs>
	<style type="text/css"><![CDATA[
	@font-face {
	font-family: "Lemon/Milk";
	  src: url("fonts/LemonMilk.otf");
	  font-weight: normal;
	  font-style: normal;
	}
	
	@font-face {
	  font-family: "Bitstream Vera Sans Mono";
	  src: url("fonts/VeraMono.ttf");
	  font-weight: normal;
	  font-style: normal;
	}

	svg {
	  font-size: 12px;
	}

	text {
	  font-family: "Bitstream Vera Sans Mono";
	  font-size: 3em;
	}
	
	#name-title {
	  font-family: "Lemon/Milk";
	  font-size: 7em;	       
	}
	
	.big-section-title {
	  font-family: "Lemon/Milk";
	  font-size: 4em;
	}
	
	.experience-field {
	  fill: #696969;
	  font-size:4em;
	}
	
	.experience-field .minor {
	  font-size: 0.75em;
	  fill: #B2B2B2;
	}
	
	.section-title {
	  font-family: "Lemon/Milk";
	  font-size: 3em;
	}
	
	]]></style>
      </defs>
      <xsl:apply-templates select="general|languages|education|jobs" />      
    </svg>
  </xsl:template>

  <xsl:template match="general">
    <!-- HEADER -->
    <text id="name-title" x="50%" y="240" text-anchor="middle" ><xsl:value-of select="name" /></text>
    <line  x1="5%" y1="175.5" x2="20%" y2="175.5" stroke="black" stroke-width="10px" />
    <line  x1="80%" y1="175.5" x2="95%" y2="175.5" stroke="black" stroke-width="10px" />

    <!-- GENERAL -->
    <image x="5%" y="351" width="2%" height="50" xlink:href="img/info21.svg" />
    <line x1="5%" y1="412" x2="45%" y2="412" stroke="black" stroke-width="6px" />
    <text class="section-title" x="8%" y="403.65">Personal Details</text>
    
    <!-- GENERAL LIST -->
    <xsl:variable name="fieldXOffset" select="0.18" />
    <xsl:variable name="valueXOffset" select="0.19" />
    <xsl:variable name="startYOffset" select="0.135" />
    <xsl:for-each select="descendant::*[not(count(*))]">
      <text class="general-field">
	<xsl:attribute name="x"><xsl:value-of select="format-number($fieldXOffset, '0.00%')" /></xsl:attribute>
	<xsl:attribute name="y"><xsl:value-of select="3510 * ($startYOffset + ( position() - 1 ) * 0.015)" /></xsl:attribute>
	<tspan fill="#696969" text-anchor="end"><xsl:value-of select="name()" /></tspan>
	<tspan>
	  <xsl:attribute name="x"><xsl:value-of select="format-number($valueXOffset, '0.00%')"/></xsl:attribute>
	  <xsl:value-of select="." />
	</tspan>
      </text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="languages">
    <!-- LANGUAGES -->
    <image x="50%" y="351" width="2%" height="50" xlink:href="img/planet5.svg" />
    <line x1="50%" y1="412" x2="95%" y2="412" stroke="black" stroke-width="6px" />
    <text class="section-title" x="53%" y="403.65">Languages</text>

    <xsl:variable name="startYOffset" select="0.135" />
    <xsl:variable name="xOffset" select="0.52" />
    <xsl:variable name="yIncrement" select="0.015" />
    <xsl:variable name="maxLength" select="max(
					   for $lang in ( ./language/text() )
					     return string-length($lang)
					   ) * 0.01" />
    <xsl:for-each select="language" >
      <xsl:variable name="yPos" select="$startYOffset + ( position() - 1 ) * $yIncrement" />
      <text class="language-field" >
	<xsl:attribute name="x"><xsl:value-of select="format-number($xOffset, '0.00%')" /></xsl:attribute>
	<xsl:attribute name="y"><xsl:value-of select="3510 * $yPos" /></xsl:attribute>
	<xsl:value-of select="." />
      </text>
      <xsl:variable name="starXOffset" select="0.95" />
      <xsl:for-each select="1 to @ability" >
	<image width="1.5%" height="52" xlink:href="img/star174.svg" >
	  <xsl:attribute name="x"><xsl:value-of select="format-number($starXOffset - position() * 0.02, '0.00%')"/></xsl:attribute>
	  <xsl:attribute name="y"><xsl:value-of select="3510 * ($yPos - 0.011)" /></xsl:attribute>
	</image>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="education">
    <xsl:variable name="generalHeight" select="count(//general/*[not(count(*))]) * 0.015 + 0.135" />
    <xsl:variable name="languageHeight" select="count(//languages/langauge) * 0.015 + 0.135" />
    <xsl:variable name="minYOffset" select="max(($languageHeight, $generalHeight)) + 0.025" />

    <!-- EDUCATION -->
    <image x="5%" width="4%" height="140" xlink:href="img/books30.svg" >
      <xsl:attribute name="y"><xsl:value-of select="3510 * $minYOffset" /></xsl:attribute>
    </image>
    <line x1="5%" x2="95%" stroke="black" stroke-width="8px" >
      <xsl:attribute name="y1"><xsl:value-of select="3510 * ($minYOffset+0.04)" /></xsl:attribute>
      <xsl:attribute name="y2"><xsl:value-of select="3510 * ($minYOffset+0.04)" /></xsl:attribute>
    </line>
    <text class="big-section-title" x="10%">
      <xsl:attribute name="y"><xsl:value-of select="3510 * ($minYOffset+0.03)" /></xsl:attribute>
      Education
    </text>

    <xsl:variable name="schoolYOffset" select="$minYOffset + 0.04 + 0.015" />
    <xsl:variable name="infoYOffset" select="$minYOffset + 0.04 + 0.015 + 0.015" />
    <xsl:variable name="schoolXOffset" select="0.05" />
    <xsl:variable name="infoXOffset" select="0.10" />
    <xsl:variable name="yIncrement" select="0.03" />
    <xsl:for-each select="education-entry">
      <!-- EDUCATION LIST -->
      <text class="education-field" font-weight="bold">
	<xsl:attribute name="x"><xsl:value-of select="format-number($schoolXOffset, '0.00%')" /></xsl:attribute>
	<xsl:attribute name="y"><xsl:value-of select="3510 * ($schoolYOffset + ( ( position() - 1 ) * $yIncrement ))" /></xsl:attribute>
	<xsl:value-of select="major" />
       </text>
      <text class="education-field">
	<xsl:attribute name="x"><xsl:value-of select="format-number($infoXOffset, '0.00%')" /></xsl:attribute>
	<xsl:attribute name="y"><xsl:value-of select="3510 * ($infoYOffset + ( ( position() - 1 ) * $yIncrement ))" /></xsl:attribute>
	<xsl:value-of select="concat(school, ', ', @start, '-', @end)" />
      </text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="jobs">
    <xsl:variable name="generalHeight" select="count(//general/*[not(count(*))]) * 0.015 + 0.135" />
    <xsl:variable name="languageHeight" select="count(//languages/language) * 0.015 + 0.135" />
    <xsl:variable name="eduMinYOffset" select="max(($languageHeight, $generalHeight)) + 0.025" />
    <xsl:variable name="educationHeight" select="$eduMinYOffset + count(//education/*) * 0.03 + 0.04" />
    <xsl:variable name="minYOffset" select="$educationHeight" />

    <image x="5%" width="4%" height="140" xlink:href="img/man379.svg" >
      <xsl:attribute name="y"><xsl:value-of select="3510 * $minYOffset" /></xsl:attribute>
    </image>
    <line x1="5%" x2="95%" stroke="black" stroke-width="8px" >
      <xsl:attribute name="y1"><xsl:value-of select="3510 * ($minYOffset+0.04)" /></xsl:attribute>
      <xsl:attribute name="y2"><xsl:value-of select="3510 * ($minYOffset+0.04)" /></xsl:attribute>
    </line>
    <text class="big-section-title" x="10%" >
      <xsl:attribute name="y"><xsl:value-of select="3510 * ($minYOffset+0.03)" /></xsl:attribute>
      Experience
    </text>

    <xsl:call-template name="job-loop" >
      <xsl:with-param name="jobs" select="//job" />
      <xsl:with-param name="paramYOffset" select="$minYOffset + 0.04 + 0.03"/>
    </xsl:call-template>

    

  </xsl:template>

  <xsl:template name="job-loop">
    <xsl:param name="jobs" />
    <xsl:param name="paramYOffset" />
    
    <xsl:if test="count($jobs) > 0" >
      <xsl:variable name="job" select="$jobs[1]" />
      <xsl:variable name="languages" select="//language-entry[@id = tokenize($job/technology/@languages, ',')]" />
      <xsl:variable name="frameworks" select="//framework-entry[@id = tokenize($job/technology/@frameworks, ',')]" />
      <xsl:variable name="others" select="//other-entry[@id = tokenize($job/technology/@others, ',')]" />
      <xsl:variable name="software" select="//software-entry[@id = tokenize($job/technology/@software, ',')]" />
      <xsl:variable name="all" select="($languages, $frameworks, $others, $software)" />
      <xsl:variable name="splitLines" select="tokenize($job/description, '\n')" />
      <xsl:variable name="descrLines" select="for $line in $splitLines
					      return if(string-length($line) > 100)
					          then (normalize-space(substring($line, 1, max(index-of(string-to-codepoints(substring($line, 1, 100)), 32)))), 
						  normalize-space(substring($line, max(index-of(string-to-codepoints(substring($line, 1, 100)), 32)) + 1)))
					          else normalize-space($line)" />
      <xsl:variable name="yOffset">
	<xsl:choose>
	  <xsl:when test="$paramYOffset &lt; 1.0 and ($paramYOffset + 0.02 + count($descrLines) * 0.015 + ((string-length(string-join($all, ' ')) div 100) + 1) * 0.03 + 0.015) &gt; 1.0">
	    <xsl:value-of select="1.05" />
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$paramYOffset" />
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <text class="experience-field" x="8%">
	<xsl:attribute name="y"><xsl:value-of select="3510 * ($yOffset)" /></xsl:attribute>
	<tspan font-weight="bold"><xsl:value-of select="$job/position" /></tspan>
	<xsl:value-of select="concat(' at ', $job/company)" />
	<tspan class="minor" dx="2%" >
	  <xsl:value-of select="$job/location" />
	  <xsl:choose>
	    <xsl:when test="not($job/@end)">
	      <xsl:value-of select="concat(' from ', $job/@start)" />
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="concat(' from ', $job/@start, ' to ', $job/@end)" />
	    </xsl:otherwise>
	  </xsl:choose>
	</tspan>
      </text>
      <!-- <text x="91%" y="31%" text-anchor="end"> -->
      <!-- 	<xsl:attribute name="y"><xsl:value-of select="3510 * ($yOffset)" /></xsl:attribute> -->
      <!-- 	<xsl:value-of select="$job/location" /> -->
      <!-- </text> -->
      <!-- <text class="experience-date" x="8%"> -->
      <!-- 	<xsl:attribute name="y"><xsl:value-of select="3510 * ($yOffset+0.015)" /></xsl:attribute> -->
	
      <!-- </text> -->
       
      <text class="experience-desc" x="8%">
	<xsl:attribute name="y"><xsl:value-of select="3510 * ($yOffset+0.02)" /></xsl:attribute>
	<xsl:for-each select="$descrLines" >
	  <tspan>
	    <xsl:attribute name="x"><xsl:value-of select="format-number(0.08, '0.00%')" /></xsl:attribute>
	    <xsl:if test="position() > 1">
	      <xsl:attribute name="dy"><xsl:value-of select="3510 * (0.015)" /></xsl:attribute>
	    </xsl:if>
	    <xsl:value-of select="." />
	  </tspan>
	</xsl:for-each>
      </text>
      
      <xsl:variable name="bubbleX" select="0.08" />
      <xsl:variable name="bubbleY" select="$yOffset + 0.005  + count($descrLines) * 0.015" />

      <xsl:call-template name="tag-loop">
	<xsl:with-param name="tags" select="$all" />
	<xsl:with-param name="index" select="1" />
	<xsl:with-param name="xOffset" select="$bubbleX" />
	<xsl:with-param name="yOffset" select="$bubbleY" />
      </xsl:call-template>

      <xsl:call-template name="job-loop" >
	<xsl:with-param name="jobs" select="$jobs[position() > 1]" />
	<xsl:with-param name="paramYOffset" select="$yOffset + 0.02 + count($descrLines) * 0.015 + ((string-length(string-join($all, ' ')) div 100) + 1) * 0.03 + 0.015"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="tag-loop">
    <xsl:param name="tags" />
    <xsl:param name="index" as="xs:integer" />
    <xsl:param name="xOffset" as="xs:decimal" />
    <xsl:param name="yOffset" />
    
    <xsl:variable name="width" select="string-length($tags[$index]) * 0.01 + 0.02" />
    <xsl:variable name="currXOff" select="if($xOffset+$width > 0.95)
					    then 0.08
					    else $xOffset" />
    <xsl:variable name="currYOff" select="if($xOffset+$width > 0.95)
					    then $yOffset + 0.03
					    else $yOffset" />
    
    <rect height="70" fill="#7ACCC8" >
      <xsl:attribute name="x"><xsl:value-of select="format-number($currXOff, '0.00%')" /></xsl:attribute>
      <xsl:attribute name="y"><xsl:value-of select="3510 * $currYOff" /></xsl:attribute>
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
      <xsl:attribute name="y"><xsl:value-of select="3510 * ($currYOff + 0.015)" /></xsl:attribute>
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
