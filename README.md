# BracketBox [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

BracketBox is an Objective-C wrapper of Facebook's CSS flexbox [implementation](https://github.com/facebook/css-layout). For the original Swift wrapper see [SwiftBox](https://github.com/joshaber/SwiftBox).

Check out [BracketBoxExamples](https://github.com/andersfrank/BracketBoxExamples) to se BracketBox in action.

## Supported Attributes

Name | Value
----:|------
width, height | `CGFloat`
margin | `BBEdges`
topMargin, leftMargin, bottomMargin, rightMargin | `CGFloat`
padding | `BBEdges`
topPadding, leftPadding, bottomPadding, rightPadding | `CGFloat`
flexDirection | 'BBFlowDirectionColumn', 'BBFlowDirectionRow'
justification | 'BBJustificationFlexStart', 'BBJustificationCenter', 'BBJustificationFlexEnd', 'BBJustificationSpaceBetween', 'BBJustificationSpaceAround'
childAlignment | 'BBChildAlignmentFlexStart', 'BBChildAlignmentCenter', 'BBChildAlignmentFlexEnd', 'BBChildAlignmentStretch'
selfAlignment | 'BBSelfAlignmentAuto', 'BBSelfAlignmentFlexStart', 'BBSelfAlignmentCenter', 'BBSelfAlignmentFlexEnd', 'BBSelfAlignmentStretch'
flex | `CGFloat`
flexWrap | `BOOL`
