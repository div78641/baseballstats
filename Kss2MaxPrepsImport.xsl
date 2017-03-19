<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:rsb="urn:www.pointstreak.com-scoringbaseball:scoresheet_v3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="iso-8859-1" indent="no" omit-xml-declaration="yes"/>

<xsl:template match="/">
	<xsl:text>8431d600-a52e-43de-967e-0bb687ec0142	
Jersey|AtBats|Runs|Hits|RunsBattedIn|Singles|Doubles|Triples|HomeRuns|SacrificeFly|SacrificeBunt|BaseOnBalls|StruckOut|HitByPitch|ReachedOnError|FieldersChoice|StolenBase|StolenBaseAttempts|LeftOnBase|PutOuts|Assists|Errors|DoublePlays|StolenBaseAttemptsCatcher|CaughtStealing|PassedBalls|Start|Win|Loss|Save|Appearances|CompleteGame|NoHitter|PerfectGame|ShutOut|InningsPitched|PartialInningPitched|BattersFaced|RunsAgainst|EarnedRuns|HitsAgainst|DoublesAgainst|TriplesAgainst|HomeRunsAgainst|SacrificeFlyPitcher|SacrificeBuntPitcher|BaseOnBallsAgainst|BattersStruckOut|HitBatter|Balks|WildPitches|NumberOfPitches|PickOffs|StolenBasesPitcher
</xsl:text>
<xsl:text>--visiting team--
</xsl:text>
	<xsl:call-template name="BuildVisitorStats"/>
<xsl:text>--home team--
</xsl:text>
	<xsl:call-template name="BuildHomeStats"/>
</xsl:template>

<xsl:template name="BuildVisitorStats">
	<xsl:for-each select="/rsb:ScoringBaseball/rsb:VisitingTeam/rsb:BattingLineup/rsb:Player[not(@Number=preceding-sibling::rsb:Player/@Number)]">
		<xsl:variable name="playerNumber" select="./@Number"/>
		<xsl:value-of select="$playerNumber"/>
		<xsl:call-template name="ParseBatting">
			<xsl:with-param name="player" select="/rsb:ScoringBaseball/rsb:VisitingTeam/rsb:BattingStatistics/rsb:Player[@Number=$playerNumber]"/>
		</xsl:call-template>
		<xsl:call-template name="ParseFielding">
			<xsl:with-param name="player" select="/rsb:ScoringBaseball/rsb:VisitingTeam/rsb:FieldingStatistics/rsb:Player[@Number=$playerNumber]"/>
			<xsl:with-param name="side" select="'visitor'"/>
			<xsl:with-param name="fielderNumber" select="$playerNumber"/>
		</xsl:call-template>
		<xsl:call-template name="ParsePitching">
			<xsl:with-param name="player" select="/rsb:ScoringBaseball/rsb:VisitingTeam/rsb:PitchingStatistics/rsb:Player[@Number=$playerNumber]"/>
		</xsl:call-template>
		<xsl:text>
</xsl:text>
	</xsl:for-each>
</xsl:template>

<xsl:template name="BuildHomeStats">
	<xsl:for-each select="/rsb:ScoringBaseball/rsb:HomeTeam/rsb:BattingLineup/rsb:Player[not(@Number=preceding-sibling::rsb:Player/@Number)]">
		<xsl:variable name="playerNumber" select="./@Number"/>
		<xsl:value-of select="$playerNumber"/>
		<xsl:call-template name="ParseBatting">
			<xsl:with-param name="player" select="/rsb:ScoringBaseball/rsb:HomeTeam/rsb:BattingStatistics/rsb:Player[@Number=$playerNumber]"/>
		</xsl:call-template>
		<xsl:call-template name="ParseFielding">
			<xsl:with-param name="player" select="/rsb:ScoringBaseball/rsb:HomeTeam/rsb:FieldingStatistics/rsb:Player[@Number=$playerNumber]"/>
			<xsl:with-param name="side" select="'home'"/>
			<xsl:with-param name="fielderNumber" select="$playerNumber"/>
		</xsl:call-template>
		<xsl:call-template name="ParsePitching">
			<xsl:with-param name="player" select="/rsb:ScoringBaseball/rsb:HomeTeam/rsb:PitchingStatistics/rsb:Player[@Number=$playerNumber]"/>
		</xsl:call-template>
		<xsl:text>
</xsl:text>
	</xsl:for-each>
</xsl:template>

<xsl:template name="ParseBatting">
	<xsl:param name="player"/>
	<xsl:choose>
		<xsl:when test="$player">
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@AB">
					<xsl:value-of select="$player/@AB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@R">
					<xsl:value-of select="$player/@R"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@H">
					<xsl:value-of select="$player/@H"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@RBI">
					<xsl:value-of select="$player/@RBI"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@H and $player/@_2B and $player/@_3B and $player/@HR">
					<xsl:value-of select="$player/@H - $player/@_2B - $player/@_3B - $player/@HR"/>
				</xsl:when>
				<xsl:when test="$player/@H and $player/@_2B and $player/@_3B">
					<xsl:value-of select="$player/@H - $player/@_2B - $player/@_3B"/>
				</xsl:when>
				<xsl:when test="$player/@H and $player/@_2B and $player/@HR">
					<xsl:value-of select="$player/@H - $player/@_2B - $player/@HR"/>
				</xsl:when>
				<xsl:when test="$player/@H and $player/@_3B and $player/@HR">
					<xsl:value-of select="$player/@H - $player/@_3B - $player/@HR"/>
				</xsl:when>
				<xsl:when test="$player/@H and $player/@_2B">
					<xsl:value-of select="$player/@H - $player/@_2B"/>
				</xsl:when>
				<xsl:when test="$player/@H and $player/@_3B">
					<xsl:value-of select="$player/@H - $player/@_3B"/>
				</xsl:when>
				<xsl:when test="$player/@H and $player/@HR">
					<xsl:value-of select="$player/@H - $player/@HR"/>
				</xsl:when>
				<xsl:when test="$player/@H">
					<xsl:value-of select="$player/@H"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_2B">
					<xsl:value-of select="$player/@_2B"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_3B">
					<xsl:value-of select="$player/@_3B"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@HR">
					<xsl:value-of select="$player/@HR"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@SF">
					<xsl:value-of select="$player/@SF"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@SH">
					<xsl:value-of select="$player/@SH"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@BB">
					<xsl:value-of select="$player/@BB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@SO">
					<xsl:value-of select="$player/@SO"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@HP">
					<xsl:value-of select="$player/@HP"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@OE">
					<xsl:value-of select="$player/@OE"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@FC">
					<xsl:value-of select="$player/@FC"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@SB">
					<xsl:value-of select="$player/@SB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@SB and $player/@CS">
					<xsl:value-of select="$player/@SB + $player/@CS"/>
				</xsl:when>
				<xsl:when test="$player/@SB and not($player/@CS)">
					<xsl:value-of select="$player/@SB"/>
				</xsl:when>
				<xsl:when test="not($player/@SB) and $player/@CS">
					<xsl:value-of select="$player/@CS"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@LOB">
					<xsl:value-of select="$player/@LOB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>||||||||||||||||||</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="ParseFielding">
	<xsl:param name="player"/>
	<xsl:param name="side"/>
	<xsl:param name="fielderNumber"/>
	<xsl:choose>
		<xsl:when test="$player">
			<xsl:variable name="isCatcher">
				<xsl:choose>
					<xsl:when test="$side = 'visitor'">
						<xsl:choose>
							<xsl:when test="/rsb:ScoringBaseball/rsb:VisitingTeam/rsb:BattingLineup/rsb:Player[@Number = $fielderNumber and @Position ='C']">
								<xsl:value-of select="1"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="0"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="/rsb:ScoringBaseball/rsb:HomeTeam/rsb:BattingLineup/rsb:Player[@Number = $fielderNumber and @Position ='C']">
								<xsl:value-of select="1"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="0"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@PO">
					<xsl:value-of select="$player/@PO"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@A">
					<xsl:value-of select="$player/@A"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@E">
					<xsl:value-of select="$player/@E"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@DP">
					<xsl:value-of select="$player/@DP"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$isCatcher = 1">
					<xsl:choose>
						<xsl:when test="$player/@SBA">
							<xsl:value-of select="$player/@SBA"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>0</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>|</xsl:text>
					<xsl:choose>
						<xsl:when test="$player/@CS">
							<xsl:value-of select="$player/@CS"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>0</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>|</xsl:text>
					<xsl:choose>
						<xsl:when test="$player/@PB">
							<xsl:value-of select="$player/@PB"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>0</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>||</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>|||||||</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="ParsePitching">
	<xsl:param name="player"/>
	<xsl:choose>
		<xsl:when test="$player">
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_GS">
					<xsl:value-of select="$player/@_GS"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_W">
					<xsl:value-of select="$player/@_W"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_L">
					<xsl:value-of select="$player/@_L"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_SV">
					<xsl:value-of select="$player/@_SV"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_G">
					<xsl:value-of select="$player/@_G"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_CG">
					<xsl:value-of select="$player/@_CG"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_SHO">
					<xsl:value-of select="$player/@_SHO"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<!-- NoHitter -->
			<xsl:text>|0</xsl:text>
			<!-- PerfectGame -->
			<xsl:text>|0</xsl:text>
			<xsl:text>|</xsl:text>
			<xsl:value-of select="substring-before($player/@IP,'.')"/>
			<xsl:text>|</xsl:text>
			<xsl:value-of select="substring-after($player/@IP,'.')"/>
			<xsl:text>|</xsl:text>
			<xsl:value-of select="$player/@BF"/>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_R">
					<xsl:value-of select="$player/@_R"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@ER">
					<xsl:value-of select="$player/@ER"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_H">
					<xsl:value-of select="$player/@_H"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@__2B">
					<xsl:value-of select="$player/@__2B"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@__3B">
					<xsl:value-of select="$player/@__3B"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_HR">
					<xsl:value-of select="$player/@_HR"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_SF">
					<xsl:value-of select="$player/@_SF"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_SH">
					<xsl:value-of select="$player/@_SH"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_BB">
					<xsl:value-of select="$player/@_BB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_SO">
					<xsl:value-of select="$player/@_SO"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_HBP">
					<xsl:value-of select="$player/@_HBP"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_BK">
					<xsl:value-of select="$player/@_BK"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@WP">
					<xsl:value-of select="$player/@WP"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@B and $player/@S">
					<xsl:value-of select="$player/@B + $player/@S"/>
				</xsl:when>
				<xsl:when test="$player/@B and not($player/@S)">
					<xsl:value-of select="$player/@B"/>
				</xsl:when>
				<xsl:when test="not($player/@B) and $player/@S">
					<xsl:value-of select="$player/@S"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>|0|</xsl:text>
			<xsl:choose>
				<xsl:when test="$player/@_SB">
					<xsl:value-of select="$player/@_SB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>||||||||||||||||||||||||||||</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>