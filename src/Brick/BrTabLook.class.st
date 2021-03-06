Class {
	#name : #BrTabLook,
	#superclass : #BrLook,
	#category : 'Brick-Tabs - Look'
}

{ #category : #initialization }
BrTabLook >> initializeListeners [
	super initializeListeners.
	
	self when: BrTabSelectedEvent do: [ self tabSelected ].
	self when: BrTabDeselectedEvent do: [ self tabDeselected ].
	self when: BrTabEnabledEvent do: [ self tabEnabled ].
	self when: BrTabDisabledEvent do: [ self tabDisabled ]
]

{ #category : #initialization }
BrTabLook >> initializeLook [
	super initializeLook.

	"here we define default tab look (independent from the view model)"
	self tabDeselected.
	self tabEnabled
]

{ #category : #initialization }
BrTabLook >> initializeRequests [
	super initializeRequests.
	
	self request: BrTabStateRequest new
]

{ #category : #'event handling' }
BrTabLook >> tabDeselected [
]

{ #category : #'event handling' }
BrTabLook >> tabDisabled [
]

{ #category : #'event handling' }
BrTabLook >> tabEnabled [
]

{ #category : #'event handling' }
BrTabLook >> tabSelected [
]
