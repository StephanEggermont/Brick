"
Example:

[[[
anEditor := BrTextEditor new.
anEditor inserter
	atCursor;
	string: 'Hello';
	insert.
anEditor
]]]
"
Class {
	#name : #BrTextEditorInserter,
	#superclass : #BrTextEditorOperator,
	#instVars : [
		'insertionIndices',
		'text',
		'shouldUpdateCursor',
		'shouldUpdateSelection',
		'shouldDeleteSelected'
	],
	#category : #'Brick-Editor-Model'
}

{ #category : #'api - configuration' }
BrTextEditorInserter >> at: anIndex [
	"Add a given index as another text insertion location"

	(insertionIndices includes: anIndex)
		ifFalse: [ insertionIndices add: anIndex ]
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> atCursor [
	self cursor do: [ :aCursor | self at: aCursor position ]
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> atEnd [
	"Insert a text at the very end"
	self at: self text size
]

{ #category : #private }
BrTextEditorInserter >> computeIndexMovement: anIndex afterInserted: aText at: anInsertionIndex [
	"Compute by how much a given text index should be moved after a privided text is inserted at a given insertion index"
	<return: #Number>

	^ anIndex < anInsertionIndex
		ifTrue: [ 0 ]
		ifFalse: [ aText size ]
]

{ #category : #private }
BrTextEditorInserter >> computeSelection: aSelection afterInserted: aText at: anInsertionIndex [
	<return: #BlSelection>

	aSelection to <= anInsertionIndex
		ifTrue: [ ^ aSelection ].

	aSelection from >= anInsertionIndex
		ifTrue: [ ^ BlSelection
			from: aSelection from + aText size
			to: aSelection to + aText size ].

	^ BlSelection
		from: aSelection from
		to: aSelection to + aText size
]

{ #category : #private }
BrTextEditorInserter >> deleteSelectedText [
	| aDeleter newInsertionIndices |
	
	aDeleter := self editor deleter.
	aDeleter selected.

	newInsertionIndices := SortedCollection new.
	insertionIndices do: [ :anIndex |
		newInsertionIndices add: (anIndex + (aDeleter computeIndexMovement: anIndex)) ].
	
	insertionIndices := newInsertionIndices.
	
	aDeleter delete
]

{ #category : #initialization }
BrTextEditorInserter >> initialize [
	super initialize.
	
	insertionIndices := SortedCollection new.
	shouldUpdateCursor := true.
	shouldUpdateSelection := true.
	shouldDeleteSelected := true
]

{ #category : #'api - processing' }
BrTextEditorInserter >> insert [
	shouldDeleteSelected
		ifTrue: [ self deleteSelectedText ].
		
	insertionIndices reverseDo: [ :anIndex |
		self privateInsertString: text at: anIndex.

		shouldUpdateCursor
			ifTrue: [ self updateCursorsAfterInsertion: text at: anIndex ].
		shouldUpdateSelection
			ifTrue: [ self updateSelectionAfterInsertion: text at: anIndex ] ]
]

{ #category : #private }
BrTextEditorInserter >> privateInsertString: aString at: aTextIndex [
	| aCommand |

	aCommand := BrTextEditorInsertStringCommand new
		string: aString;
		index: aTextIndex.
	self editor enqueueCommand: aCommand
]

{ #category : #'private - accessing' }
BrTextEditorInserter >> shouldDeleteSelected [
	^ shouldDeleteSelected
]

{ #category : #'private - accessing' }
BrTextEditorInserter >> shouldDeleteSelected: aBoolean [
	shouldDeleteSelected := aBoolean
]

{ #category : #'private - accessing' }
BrTextEditorInserter >> shouldUpdateCursor [
	^ shouldUpdateCursor
]

{ #category : #'private - accessing' }
BrTextEditorInserter >> shouldUpdateCursor: anObject [
	shouldUpdateCursor := anObject
]

{ #category : #'private - accessing' }
BrTextEditorInserter >> shouldUpdateSelection [
	^ shouldUpdateSelection
]

{ #category : #'private - accessing' }
BrTextEditorInserter >> shouldUpdateSelection: anObject [
	shouldUpdateSelection := anObject
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> string: aString [
	text := aString
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> text: aBlText [
	text := aBlText
]

{ #category : #private }
BrTextEditorInserter >> updateCursorsAfterInsertion: aText at: anIndex [
	self cursor do: [ :aCursor |
		| aCursorDelta |
		aCursorDelta := self
			computeIndexMovement: aCursor position
			afterInserted: aText
			at: anIndex.

		aCursorDelta isZero
			ifFalse: [ self editor navigator
				move: aCursor by: aCursorDelta;
				apply ] ]
]

{ #category : #private }
BrTextEditorInserter >> updateSelectionAfterInsertion: aText at: anIndex [
	| anExistingSelection |
	
	anExistingSelection := BlCompositeSelection new select: self editor selection.
	anExistingSelection reverseDo: [ :aMonotoneSelection |
		| aNewSelection |
		
		aNewSelection := self computeSelection: aMonotoneSelection afterInserted: aText at: anIndex.
		aNewSelection = aMonotoneSelection
			ifFalse: [
				self editor deselect: aMonotoneSelection from to: aMonotoneSelection to.
				self editor select: aNewSelection from to: aNewSelection to ] ]
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> withSelectionDelete [
	shouldDeleteSelected := true
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> withoutCursorUpdate [
	shouldUpdateCursor := false
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> withoutSelectionDelete [
	shouldDeleteSelected := false
]

{ #category : #'api - configuration' }
BrTextEditorInserter >> withoutSelectionUpdate [
	shouldUpdateSelection := false
]
