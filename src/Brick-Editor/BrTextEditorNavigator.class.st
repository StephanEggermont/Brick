"
I am responsible for cursor navigation.

- First I perform all cursor remove operations.
- Then I add new cursors
- and finally perform cursor movement operations
"
Class {
	#name : #BrTextEditorNavigator,
	#superclass : #BrTextEditorOperator,
	#instVars : [
		'cursorsToAdd',
		'cursorsToRemove',
		'cursorsToMove'
	],
	#category : #'Brick-Editor-Model'
}

{ #category : #'api - configuration' }
BrTextEditorNavigator >> add: aCursor [
	"Add a given cursor at the position specified in the added cursor"
	self privateAssertPosition: aCursor position.
		
	cursorsToAdd add: aCursor
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> addAt: aTextPosition [
	"Add a cursor at a given text position"
	self privateAssertPosition: aTextPosition.
		
	cursorsToAdd add: (self privateNewCursorAt: aTextPosition)
]

{ #category : #'api - processing' }
BrTextEditorNavigator >> apply [
	| theCurrentCursors theNewCursors theSameCursors theAddedCursors theRemovedCursors theMovedCursors theCurrentCursorsArray theNewCursorsArray |
	
	theCurrentCursors := self cursor allCursors asSet.
	theNewCursors := (self cursor allCursors collect: #copy) asSet.

	self privateRemoveRegisteredIn: theNewCursors.
	self privateAddRegisteredIn: theNewCursors.
	self privateMoveRegisteredIn: theNewCursors.
	
	theSameCursors := theCurrentCursors intersection: theNewCursors.

	theCurrentCursors removeAll: theSameCursors.
	theNewCursors removeAll: theSameCursors.
	
	theCurrentCursorsArray := theCurrentCursors sorted: [ :a :b | a position < b position ].
	theNewCursorsArray := theNewCursors sorted: [ :a :b | a position < b position ].

	theMovedCursors := OrderedCollection new.
	theAddedCursors := OrderedCollection new.
	theRemovedCursors := OrderedCollection new.

	1 to: (theCurrentCursorsArray size max: theNewCursorsArray size) do: [ :anIndex |
		((anIndex <= theCurrentCursorsArray size) and: [ anIndex <= theNewCursorsArray size  ])
			ifTrue: [ theMovedCursors add: (theCurrentCursorsArray at: anIndex) -> (theNewCursorsArray at: anIndex) ]
			ifFalse: [ anIndex > theCurrentCursorsArray size
				ifTrue: [ theAddedCursors add: (theNewCursorsArray at: anIndex) ]
				ifFalse: [ theRemovedCursors add: ((theCurrentCursorsArray at: anIndex)) ] ] ].

	theRemovedCursors do: [ :aCursor | self privateRemoveCursor: aCursor ].
	theAddedCursors do: [ :aCursor | self privateAddCursor: aCursor ].
	theMovedCursors do: [ :anAssociation | self privateMoveCursor: anAssociation key to: anAssociation value position ]
]

{ #category : #initialization }
BrTextEditorNavigator >> initialize [
	super initialize.

	cursorsToAdd := Set new.
	cursorsToRemove := Set new.
	cursorsToMove := Dictionary new
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> move: aCursor by: aDelta [
	"Move a given cursor by a provided delta"

	cursorsToMove at: aCursor put: aDelta
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> move: aCursor to: aTextPosition [
	"Move a given cursor to a provided position"
	self privateAssertPosition: aTextPosition.

	cursorsToMove at: aCursor put: (aTextPosition - aCursor position)
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> moveBy: aDelta [
	"Move all cursors by a given delta. The operation is only applied on existing cursor, not the ones that will be added"

	aDelta isZero
		ifTrue: [ ^ self ].

	self cursor do: [ :aCursor |
		cursorsToMove at: aCursor put: aDelta ]
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> moveLeft [
	"Move all cursors one to the left"
	
	self moveBy: -1
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> moveRight [
	"Move all cursors one to the right"
	
	self moveBy: 1
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> moveTo: aTextPosition [
	"Move all cursors to a given position (basically, remove all cursors except one)"
	self privateAssertPosition: aTextPosition.

	self removeAll.
	self addAt: aTextPosition
]

{ #category : #notifying }
BrTextEditorNavigator >> notifyCursorAdded: aCursor [
	self editor dispatchEvent: (BrTextEditorCursorAddedEvent cursor: aCursor)
]

{ #category : #private }
BrTextEditorNavigator >> notifyCursorChangedAt: aTextIndex [
	| aCommand |

	aCommand := BrTextEditorCursorChangeCommand new
		position: aTextIndex.
	self editor enqueueCommand: aCommand
]

{ #category : #notifying }
BrTextEditorNavigator >> notifyCursorMoved: aCursor from: aFromIndex to: aToIndex [
	self editor dispatchEvent: (BrTextEditorCursorMovedEvent cursor: aCursor from: aFromIndex to: aToIndex)
]

{ #category : #notifying }
BrTextEditorNavigator >> notifyCursorRemoved: aCursor [
	self editor dispatchEvent: (BrTextEditorCursorRemovedEvent cursor: aCursor)
]

{ #category : #private }
BrTextEditorNavigator >> privateAddCursor: aNewCursor [

	self
		assert: [ self cursor allSatisfy: [ :aCursor | aCursor position ~= aNewCursor position ] ]
		description: [ 'Cursor must not exist at a given index' ].
	
	self cursor add: aNewCursor.

	self notifyCursorChangedAt: aNewCursor position.
	self notifyCursorAdded: aNewCursor
]

{ #category : #'private - operations' }
BrTextEditorNavigator >> privateAddRegisteredIn: aSet [
	(cursorsToAdd asSortedCollection: [ :a :b | a position < b position])
		do: [ :aCursor | aSet add: aCursor ]
]

{ #category : #'private - accessing' }
BrTextEditorNavigator >> privateAssertPosition: aTextPosition [
	self
		assert: [ aTextPosition between: 0 and: self text size ]
		description: [ 'Cursor position must be within the interval [0.. text size]' ].
]

{ #category : #'private - accessing' }
BrTextEditorNavigator >> privateCursorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	self cursor
		detect: [ :aCursor | aCursor position = aTextPosition ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #private }
BrTextEditorNavigator >> privateMoveCursor: aCursor to: aTextIndex [
	| anOldPosition |
	self
		assert: [ aCursor position ~= aTextIndex ]
		description: [ 'Can not move a given cursor to the same location' ].
	
	anOldPosition := aCursor position.
	aCursor position: aTextIndex.

	self notifyCursorChangedAt: anOldPosition.
	self notifyCursorChangedAt: aTextIndex.
	self notifyCursorMoved: aCursor from: anOldPosition to: aTextIndex
]

{ #category : #'private - operations' }
BrTextEditorNavigator >> privateMoveRegisteredIn: aSet [
	| theExistingCursors theRequestedCursors theMovableCursors theMergedCursors theRemovedCursor |

	theExistingCursors := (Array streamContents: [ :aStream |
		aSet do: [ :aCursor | aStream nextPut: aCursor ] ]) asSet.
	
	theRequestedCursors := cursorsToMove keys asSet.
	
	"contains existing cursors that should be moved"
	theMovableCursors := theRequestedCursors intersection: theExistingCursors.

	"contains associations newPosition -> cursor, a subset of theMovableCursors"
	theMergedCursors := Dictionary new.

	theMovableCursors do: [ :aCursor |
		| aNewPosition |
		aNewPosition := aCursor position + (cursorsToMove at: aCursor).
		aNewPosition := self privateNormalizePosition: aNewPosition.
		theMergedCursors at: aNewPosition put: aCursor ].
	
	"cursors that should be removed due to merging of moved cursors"
	theRemovedCursor := theRequestedCursors difference: theMergedCursors values.
	
	"remove them now"
	theRemovedCursor do: [ :aCursor | aSet remove: aCursor ].
	
	"cursors that we actually move"
	theMergedCursors keysAndValuesDo: [ :aNewPosition :aCursor |
		aCursor position = aNewPosition
			ifFalse: [ aCursor position: aNewPosition ] ]
]

{ #category : #'private - instance creation' }
BrTextEditorNavigator >> privateNewCursorAt: aTextPosition [
	"Create a new cursor for a given text position"
	
	^ BrTextEditorSingleCursor new position: aTextPosition
]

{ #category : #'private - accessing' }
BrTextEditorNavigator >> privateNormalizePosition: aTextPosition [
	^ (aTextPosition max: 0) min: self text size
]

{ #category : #private }
BrTextEditorNavigator >> privateRemoveCursor: aCursorToRemove [
	self
		assert: [ self cursor anySatisfy: [ :aCursor | aCursor position = aCursorToRemove position ] ]
		description: [ 'Cursor must exist at a given index' ].

	self cursor remove: aCursorToRemove.
	self notifyCursorChangedAt: aCursorToRemove position.
	self notifyCursorRemoved: aCursorToRemove
]

{ #category : #'private - operations' }
BrTextEditorNavigator >> privateRemoveRegisteredIn: aSet [
	cursorsToRemove do: [ :aCursor | aSet remove: aCursor ]
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> remove: aCursor [
	"Remove a given cursor"
	self privateAssertPosition: aCursor position.

	cursorsToRemove add: aCursor
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> removeAll [
	"Remove all cursors"
	
	self cursor do: [ :aCursor | cursorsToRemove add: aCursor ]
]

{ #category : #'api - configuration' }
BrTextEditorNavigator >> removeAt: aTextPosition [
	"Remove a cursor at a given text position"
	self privateAssertPosition: aTextPosition.

	cursorsToRemove add: (self privateNewCursorAt: aTextPosition)
]

{ #category : #'api - events' }
BrTextEditorNavigator >> whenAdded: aBlock [
	"Subscribe to the cursor added event and return an event handler"

	^ self when: BrTextEditorCursorAddedEvent do: aBlock
]

{ #category : #'api - events' }
BrTextEditorNavigator >> whenMoved: aBlock [
	"Subscribe to the cursor moved event and return an event handler"

	^ self when: BrTextEditorCursorMovedEvent do: aBlock
]

{ #category : #'api - events' }
BrTextEditorNavigator >> whenRemoved: aBlock [
	"Subscribe to the cursor removed event and return an event handler"

	^ self when: BrTextEditorCursorRemovedEvent do: aBlock
]
