Class {
	#name : #BrPagerLook,
	#superclass : #BrLook,
	#instVars : [
		'pagesListElement',
		'pages'
	],
	#category : 'Brick-Pager - Look'
}

{ #category : #initialization }
BrPagerLook >> initialize [
	super initialize.

	pages := OrderedDictionary new.
	pagesListElement := BrInfinitePagerElement new.
	pagesListElement constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #initialization }
BrPagerLook >> initializeListeners [
	super initializeListeners.

	self when: BrPagerPagesChanged do: [ :anEvent | self onPagesChanged: anEvent pages ].
	self when: BrPagerPageAddedEvent do: [ :anEvent | self onPageAdded: anEvent page ].
	self when: BrPagerPageRemovedEvent do: [ :anEvent | self onPageRemoved: anEvent page ]
]

{ #category : #initialization }
BrPagerLook >> initializeLook [
	super initializeLook.
	
	self widgetContent addChild: pagesListElement as: #list
]

{ #category : #initialization }
BrPagerLook >> initializeRequests [
	super initializeRequests.
	
	self request: BrPagerPagesRequest new
]

{ #category : #hooks }
BrPagerLook >> onPageAdded: aPageModel [
	self
		assert: [ self isAttachedToWidget ]
		description: [ 'I can not receive the page added event without being attached to a widget' ].

	self pages at: aPageModel put: nil.

	aPageModel whenAttachedDo: [ :aPageContentElement | self onPageContentAttached: aPageContentElement ]
]

{ #category : #hooks }
BrPagerLook >> onPageContentAttached: aPageContentElement [
	| aPageModel aPageElement |

	aPageModel := aPageContentElement viewModel.

	aPageContentElement removeFromParent.
	aPageElement := (aPageModel embellisher contentElement: aPageContentElement) asElement.	
	self pages at: aPageModel put: aPageElement.

	pagesListElement dataSource pageElements: self pageElements
]

{ #category : #hooks }
BrPagerLook >> onPageRemoved: aPageModel [
	self
		assert: [ self isAttachedToWidget ]
		description: [ 'I can not receive the page removed event without being attached to a widget' ].

	self pages removeKey: aPageModel.
	aPageModel widgetDo: [ :aPageContentElement | aPageContentElement removeFromParent ].
	pagesListElement dataSource pageElements: self pageElements
]

{ #category : #hooks }
BrPagerLook >> onPagesChanged: aCollectionOfModels [
	
	self pages removeAll.
	aCollectionOfModels do: [ :aPageModel |
		self pages at: aPageModel put: nil ].

	aCollectionOfModels do: [ :aPageModel |
		aPageModel whenAttachedDo: [ :aPageContentElement |
			self onPageContentAttached: aPageContentElement ] ]
]

{ #category : #accessing }
BrPagerLook >> pageElements [
	^ self pages values select: #isNotNil
]

{ #category : #accessing }
BrPagerLook >> pages [
	^ pages
]
