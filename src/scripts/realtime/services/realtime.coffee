realtime = angular.module 'patrol.realtime'
realtime.factory 'RealtimeService', ['$websocket', ($websocket) ->
	new class RealtimeService

		constructor: () ->
			@handlers = []

		init: () ->
			@ws = new WebSocket("ws://127.0.0.1:4434/api/realtime/websocket")
			@ws.onmessage = (message) =>
				data = JSON.parse(message.data)
				@fire data
				return
			@ws.onopen = () =>
				console.log "Opened"
				return
			@ws.onclose = () =>
				console.log "Closed"
				return

		close: () ->
			@ws.close()

		subscribe: (fn) ->
			@handlers.push fn

		unsubscribe: (fn) ->
			@handlers = @handlers.filter (item) ->
				if item != fn
					return item
		fire: (data) ->
			angular.forEach @handlers, (fn) ->
				fn(data)

]
