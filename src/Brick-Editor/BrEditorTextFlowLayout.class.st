"
I am a special kind of Flow layout optimized to layout small text piece elements with moldable editor's segment.

I do not support children matching parent. All of them must have either exact of fit content resizing strategies.
"
Class {
	#name : #BrEditorTextFlowLayout,
	#superclass : #BlLayout,
	#instVars : [
		'lines',
		'lineSpacing'
	],
	#category : 'Brick-Editor-Layout'
}

{ #category : #constraints }
BrEditorTextFlowLayout class >> constraints [
	^ BrEditorTextFlowLayoutConstraints new
]

{ #category : #initialization }
BrEditorTextFlowLayout >> initialize [
	super initialize.
	
	lineSpacing := 0
]

{ #category : #layout }
BrEditorTextFlowLayout >> layout: anElement in: aRectangle [
	| anOffsetX anOffsetY aLeft aTop |

	anOffsetX := anElement padding left.
	anOffsetY := anElement padding top.
	
	aLeft := anOffsetX.
	aTop := anOffsetY.
	
	lines do: [ :aLine |
		aLine elements do: [ :aChildElement |
			| aWidth aMarginedTop |
			aLeft := aLeft + aChildElement margin left.
			aMarginedTop := aTop + aChildElement margin top.
			aWidth := aChildElement measuredWidth.
			"we computed layout bounds for the element, let it apply it"
			aChildElement applyLayoutIn: (aLeft @ aMarginedTop extent: aChildElement measuredExtent).
			"offset width for the next element"
			aLeft := aLeft + aWidth + aChildElement margin right ].
		"prepare values for the next line"
		aLeft := anOffsetX.
		aTop := aTop + aLine height + lineSpacing ]
]

{ #category : #accessing }
BrEditorTextFlowLayout >> lineSpacing [
	^ lineSpacing
]

{ #category : #accessing }
BrEditorTextFlowLayout >> lineSpacing: anObject [
	lineSpacing := anObject
]

{ #category : #measure }
BrEditorTextFlowLayout >> measure: anElement with: anExtentSpec [
	| maxWidth maxHeight aCurrentLine totalContentWidth totalContentHeight |
	
	"compute how much space is available along both axes"
	maxWidth := (anExtentSpec widthSpec size ifNil: [ Float infinity ]) - anElement padding width.
	maxHeight := (anExtentSpec heightSpec size ifNil: [ Float infinity ]) - anElement padding height.

	"Actually a linked list of lines"
	lines := BrEditorTextFlowLine new maxWidth: maxWidth.
	
	"measure children and distribute them in lines"
	aCurrentLine := lines.
	anElement children accountedByLayout do: [ :aChildElement |
		self measureChildWithMargins: aChildElement parentSpec: anExtentSpec.
		aCurrentLine := aCurrentLine add: aChildElement ].

	aCurrentLine pushedQueue do: [ :aPushedElement |
		aCurrentLine := aCurrentLine nextLine.
		aCurrentLine push: aPushedElement ].

	"compute total extent to measure layout's owner element"	
	totalContentWidth := anElement padding width + lines totalWidth.
	totalContentHeight := anElement padding height + lines totalHeight.
	totalContentHeight := totalContentHeight + ((lines count - 1) * lineSpacing).

	anElement measuredExtent: (anExtentSpec sizeFor: totalContentWidth @ totalContentHeight).

	lines do: [ :aLine |
		aLine elements ifNotEmpty: [ :theElements |
			(theElements last isKindOf: BlTextEditElement)
				ifTrue: [
					theElements last measure: (BlExtentMeasurementSpec exact:
						theElements last measuredExtent + (((anElement measuredWidth - aLine width) max: 0) @ 0)) ] ] ]
]