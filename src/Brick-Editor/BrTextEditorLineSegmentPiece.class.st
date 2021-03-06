Class {
	#name : #BrTextEditorLineSegmentPiece,
	#superclass : #Object,
	#instVars : [
		'text'
	],
	#category : 'Brick-Editor-Model - Segment-Text-Line'
}

{ #category : #comparing }
BrTextEditorLineSegmentPiece >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject text = self text
]

{ #category : #'instance creation' }
BrTextEditorLineSegmentPiece >> createElement: anEditorElement [
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextEditorLineSegmentPiece >> end [
	<return: #Number>

	^ self text end
]

{ #category : #printing }
BrTextEditorLineSegmentPiece >> gtDisplayOn: aStream [
	self printOn: aStream
]

{ #category : #comparing }
BrTextEditorLineSegmentPiece >> hash [
	^ self class hash bitXor: self text hash
]

{ #category : #testing }
BrTextEditorLineSegmentPiece >> isEmpty [
	^ self text isEmpty
]

{ #category : #printing }
BrTextEditorLineSegmentPiece >> printOn: aStream [
	self text printOn: aStream
]

{ #category : #accessing }
BrTextEditorLineSegmentPiece >> start [
	<return: #Number>

	^ self text start
]

{ #category : #accessing }
BrTextEditorLineSegmentPiece >> start: aStartIndex end: anEndIndex [
	self text start: aStartIndex end: anEndIndex
]

{ #category : #accessing }
BrTextEditorLineSegmentPiece >> text [
	<return: #BlSubText>

	^ text
]

{ #category : #accessing }
BrTextEditorLineSegmentPiece >> text: aBrSubText [
	text := aBrSubText
]

{ #category : #'api - cursor' }
BrTextEditorLineSegmentPiece >> updateCursor: anElement of: aLineSegment in: anEditorElement [
	self subclassResponsibility
]

{ #category : #'selection - management' }
BrTextEditorLineSegmentPiece >> updateSelection: anElement of: aLineSegment in: anEditorElement [
	
	self subclassResponsibility
]
