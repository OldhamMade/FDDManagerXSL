<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:regexp="http://exslt.org/regular-expressions"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:random="http://exslt.org/random"
    xmlns:dyn="http://exslt.org/dynamic"
    xmlns:exsl="http://exslt.org/common"
    xmlns:str="http://exslt.org/strings"
    xmlns:math="http://exslt.org/math"
    xmlns:set="http://exslt.org/sets"
    xmlns:py="http://python.org/lxml"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:map="http://python.org/map"
    extension-element-prefixes="str date dyn exsl math random regexp set">
  
  <xsl:output
      method="xml"
      encoding="UTF-8"
      omit-xml-declaration="yes"
      indent="yes"
      />

  <xsl:template match="/">

    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
             xmlns:fox="http://xml.apache.org/fop/extensions">

      <fo:layout-master-set>
		<fo:simple-page-master master-name="FirstPageLetterLandscape" 
                               page-width="11in" 
                               page-height="8.5in"
                               margin-top="0.5in" 
                               margin-bottom="0.5in" 
                               margin-left="0.5in" 
                               margin-right="0.5in">
		  <fo:region-body margin-top="0.25in" margin-bottom="0.25in" />
		  <fo:region-before region-name="before-first" extent="3.25in"/>
		  <fo:region-after region-name="after-first" extent="0.25in"/>          
        </fo:simple-page-master>
		
		<fo:simple-page-master master-name="RestLetterLandscape"
                               page-width="11in" 
                               page-height="8.5in"
                               margin-top="0.5in" 
                               margin-bottom="0.5in" 
                               margin-left="0.5in" 
                               margin-right="0.5in">
		  <fo:region-body margin-top="0.25in" margin-bottom="0.25in" />
		  <fo:region-before extent="0.25in"/>
		  <fo:region-after extent="0.25in"/>
		</fo:simple-page-master>

        <fo:page-sequence-master master-name="document">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference master-reference="RestLetterLandscape" />
          </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>

      </fo:layout-master-set>


      <fo:page-sequence master-reference="document">
		
        <fo:static-content flow-name="xsl-region-before">
          <fo:table width="100%">
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-body>
              <fo:table-row>
                <fo:table-cell text-align="left">
                  <fo:block font-size="8pt" font-family="sans-serif">
                    Project &#8212; <xsl:value-of select="/project/name" />
                  </fo:block>
                </fo:table-cell>
                
                <fo:table-cell text-align="center">
                  <fo:block font-size="8pt" font-family="sans-serif">
                  </fo:block>
                </fo:table-cell>

                <fo:table-cell text-align="right">
                  <fo:block font-size="8pt" font-family="sans-serif">
                    Project Detail Report
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          <fo:block font-size="8pt"
                    font-family="sans-serif"
                    border-before-color="black"
                    border-before-style="solid"
                    border-before-width="0.3pt"/>
          
        </fo:static-content>
        
        <fo:static-content flow-name="xsl-region-after">
          <fo:block font-size="8pt"
                    font-family="sans-serif"
                    border-before-color="black"
                    border-before-style="solid"
                    border-before-width="0.3pt"/>

          <fo:table width="100%">
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-body>
              <fo:table-row>
                <fo:table-cell text-align="left">
                  <fo:block font-size="8pt" font-family="sans-serif">
                  Printed on <xsl:value-of select="date:date()" />.</fo:block>
                </fo:table-cell>
                
                <fo:table-cell text-align="center">
                  <fo:block font-size="8pt" font-family="sans-serif">
                  </fo:block>
                </fo:table-cell>

                <fo:table-cell text-align="right">
                  <fo:block font-size="8pt" font-family="sans-serif">
                    Page <fo:page-number/> of <fo:page-number-citation ref-id="last-page"/> 
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>

        </fo:static-content>

        <fo:flow flow-name="xsl-region-body" > 
          <fo:block font-size="18pt" 
                    font-family="sans-serif" 
                    line-height="24pt"
                    space-after.optimum="15pt"
                    background-color="black"
                    color="white"
                    text-align="center"
                    padding-top="3pt">
            <xsl:value-of select="/project/name" /> &#8212; Project Detail Report
          </fo:block>
          <fo:block font-size="8pt"
                    font-weight="bold"
                    >
			Description: 
          </fo:block>
          <fo:block white-space="pre">
			<xsl:value-of select="/project/description" />
            <xsl:if test="not(/project/description)">
              <fo:block font-style="italic">
                None set
              </fo:block>
            </xsl:if>
          </fo:block>

          <fo:block font-size="8pt" font-family="sans-serif">

            <xsl:apply-templates
                select="/project/featureList"
                mode="FeatureList"
                />

          </fo:block>

          <fo:block id="last-page"/>

        </fo:flow>

      </fo:page-sequence>

    </fo:root>

  </xsl:template>


  <xsl:template
      mode="FeatureList"
      match="featureList">

    <!-- 
         
    -->
    <fo:block 
        
        space-before.optimum="10pt" 
        space-after.optimum="10pt" 
        >

      <fo:block 
          font-size="8pt"
          font-weight="bold"
          border-before-color="black"
          border-before-style="solid"
          border-before-width="0.3pt"	
          padding-top="5pt"
          color="#555"
          >
        Features List:
      </fo:block>
      <fo:block 
          font-size="16pt"
          font-weight="bold"
          id="{translate(name,' ','-')}">
        <xsl:value-of select="name" />
      </fo:block>
      <fo:block>						
        <fo:block white-space="pre">
          <xsl:value-of select="description" />
          <xsl:if test="not(description)">
            <fo:block font-style="italic">
              No description
            </fo:block>
          </xsl:if>
        </fo:block>
      </fo:block>				
      
    </fo:block>

    <xsl:apply-templates
        select="majorFeatureSet"
        mode="MajorFeatureSet"
        />
    
    
  </xsl:template>


  <xsl:template
      mode="MajorFeatureSet"
      match="majorFeatureSet">

    <fo:block 
        space-before.optimum="10pt" 
        space-after.optimum="10pt"
        margin-left="5mm"
        margin-top="10pt"
        keep-with-next="always">
      <fo:block 
          font-size="8pt"
          font-weight="bold"
          border-before-color="black"
          border-before-style="solid"
          border-before-width="0.3pt"		
          keep-with-next="always"
          padding-top="5pt"
          color="#555"
          >
        Subject Area:
      </fo:block>
      <fo:block 
          id="{translate(../name,' ','-')}-{translate(name,' ','-')}" 
          font-size="14pt" 
          font-weight="bold"
          keep-with-next="always"
          >
        <xsl:value-of select="name" />

      </fo:block>
      
      <fo:block keep-with-next="always">						
        <fo:block white-space="pre">
          <xsl:value-of select="description" />
          <xsl:if test="not(description)">
            <fo:block font-style="italic">
              No description
            </fo:block>
          </xsl:if>
        </fo:block>
      </fo:block>

      <fo:block space-before.optimum="5pt" keep-with-next="always">
        <fo:inline font-size="8pt" font-weight="bold">
          Priority:
        </fo:inline>
        <xsl:value-of select="priority" />
      </fo:block>

    </fo:block>

    <fo:table 
        width="100%"
        space-before.optimum="10pt" 
        space-after.optimum="10pt"
        >
      <fo:table-column column-width="10mm"/>
      <fo:table-column />
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block />
          </fo:table-cell>
          <fo:table-cell text-align="left">
            
            <xsl:apply-templates
                select="featureSet"
                mode="FeatureSet"
                />  

          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>

  </xsl:template>

  
  <xsl:template
      match="featureSet"
      mode="FeatureSet">

    <fo:block font-size="8pt"
              font-weight="bold"
              border-before-color="black"
              border-before-style="solid"
              border-before-width="0.3pt"		
              space-before.optimum="20pt"
              keep-with-next="always"
              padding-top="5pt"
              color="#555"
              >
      Business Activity:
    </fo:block>
    <fo:block 
        id="{translate(../../name,' ','-')}-{translate(../name,' ','-')}-{translate(name,' ','-')}"
        font-size="12pt"
        font-weight="bold">
      <xsl:value-of select="name" />
    </fo:block>
    
    <fo:block keep-with-next="always">						
      <fo:block white-space="pre">
        <xsl:value-of select="description" />
        <xsl:if test="not(description)">
          <fo:block font-style="italic">
            No description
          </fo:block>
        </xsl:if>
      </fo:block>
    </fo:block>
    <fo:block space-before.optimum="10pt" keep-with-next="always">
      <fo:inline font-size="8pt" font-weight="bold">
        Priority:
      </fo:inline>
      <xsl:value-of select="priority" />
    </fo:block>

    <xsl:apply-templates
        mode="feature"
        select="feature"
        />
    
  </xsl:template>


  <xsl:template
      mode="feature"
      match="feature">

    <fo:block space-before.optimum="10pt">

      <fo:table width="100%">
        <fo:table-column column-width="5mm"/>
        <fo:table-column />
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block />
            </fo:table-cell>
            <fo:table-cell text-align="left">

              <fo:block space-before.optimum="10pt" space-after.optimum="2pt" keep-with-next="always">
                <fo:block font-size="8pt"
                          font-weight="bold"
                          border-before-color="black"
                          border-before-style="solid"
                          border-before-width="0.3pt"			
                          keep-together="always" 
                          padding-top="5pt"
                          color="#555"
                          >
                  Feature:
                </fo:block>
                <fo:block 
                    id="{translate(../../../name,' ','-')}-{translate(../../name,' ','-')}-{translate(../name,' ','-')}-{translate(name,' ','-')}"
                    font-size="10pt"
                    font-weight="bold"
                    keep-with-next="always"
                    >
                  <xsl:value-of select="name" />
                </fo:block>
              </fo:block>
              
              <xsl:if test="description">
                <fo:block keep-with-next="always" white-space="pre">						
                  <fo:block>
                    <xsl:value-of select="description" />
                  </fo:block>
                </fo:block>
              </xsl:if>

              <fo:table width="100%" space-before.optimum="5pt" space-after.optimum="5pt">
                <fo:table-column />
                <fo:table-column />
                <!-- fo:table-column / -->
                <fo:table-column />
                <fo:table-body>
                  <fo:table-row>
                    <fo:table-cell text-align="left">
                      <fo:block>
                        <fo:inline font-size="8pt" font-weight="bold">Development Estimate:
                        </fo:inline>
                        <xsl:value-of select="devEstimate" />&#160;<xsl:value-of select="devEstimateUnit" />
                        <xsl:if test="not(devEstimate) or devEstimate = ''">
                          &#8212;
                        </xsl:if>
                      </fo:block>
                    </fo:table-cell>
                    
                    <!-- fo:table-cell text-align="left">
                         <fo:block font-size="8pt" font-weight="bold">
                         Module:
                         </fo:block>
                         </fo:table-cell -->

                    <fo:table-cell text-align="left">
                      <fo:block>
                        <fo:inline font-size="8pt" font-weight="bold">
                          Priority:
                        </fo:inline>
                        <xsl:value-of select="priority" />
                        <xsl:if test="not(priority) or priority = ''">
                          &#8212;
                        </xsl:if>
                      </fo:block>
                    </fo:table-cell>

                    <fo:table-cell text-align="left">
                      <fo:block>
                        <fo:inline font-size="8pt" font-weight="bold">
                          Complexity:
                        </fo:inline>
                        <xsl:value-of select="complexity" />
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
              
              <xsl:apply-templates
                  mode="notes"
                  select="."
                  />

            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>

    </fo:block>
    
  </xsl:template>


  <xsl:template
      mode="notes"
      match="feature[note]">

    <fo:block font-size="8pt" font-weight="bold" margin-top="5mm" margin-bottom="3mm">
      Notes:
    </fo:block>
    <fo:block>
      <fo:table width="100%">
        <fo:table-column column-width="10mm"/>
        <fo:table-column column-width="80mm"/>
        <fo:table-column />
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell text-align="left">
              <fo:block font-size="8pt" font-weight="bold">
                ID:
              </fo:block>
            </fo:table-cell>
            
            <fo:table-cell text-align="left">
              <fo:block font-size="8pt" font-weight="bold">
                Title:
              </fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="left">
              <fo:block font-size="8pt" font-weight="bold" white-space="pre">
                Description:
              </fo:block>
            </fo:table-cell>			
          </fo:table-row>

          <xsl:apply-templates
              mode="note"
              select="note"
              />

        </fo:table-body>
      </fo:table>
    </fo:block>		

  </xsl:template>


  <xsl:template
      mode="note"
      match="note">

    <fo:table-row>
      <fo:table-cell text-align="left">
        <fo:block>
          <xsl:value-of select="position()" />
        </fo:block>
      </fo:table-cell>
      
      <fo:table-cell text-align="left">
        <fo:block>
          <xsl:value-of select="title" />
        </fo:block>
      </fo:table-cell>
      
      <fo:table-cell text-align="left">
        <fo:block>
          <xsl:value-of select="description" />
        </fo:block>
      </fo:table-cell>
    </fo:table-row>

  </xsl:template>

</xsl:stylesheet>
