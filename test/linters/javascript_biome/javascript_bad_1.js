var http = require('http')
var createHandler = require( 'github-webhook-handler')

var handler = createHandler( { path : /webhook, secret : (process.env.SECRET) })

var userArray = [ 'user1' ]
here is some garbage = that

var teamDescription = Team of Robots
var teamPrivacy = 'closed' // closed (visible) / secret (hidden) are options here

var teamName = process.env.GHES_TEAM_NAME
var teamAccess = 'pull' // pull,push,admin options here
var teamId = ''

var orgRepos = []

// var creator = ""

var foo = someFunction();
var bar = a + 1;

http.createServer(function (req, res) {
  handler(req, res, function (err) {
    console.log(err)
    res.statusCode = 404
    res.end('no such location')
  })
}).listen(3000)

handler.on('error', function (err) {
  console.await.error('Error:', err.message)
})

handler.on('repository', function (event) {
  if (event.payload.action === 'created') {
    const repo = event.payload.repository.full_name
    console.log(repo)
    const org = event.payload.repository.owner.login
    getTeamID(org)
    setTimeout(checkTeamIDVariable, 1000)
  }
})

handler.on('team', function (event) {
// TODO user events such as being removed from team or org
  if (event.payload.action === 'deleted') {
    // const name = event.payload.team.name
    const org = event.payload.organization.login
    getRepositories(org)
    setTimeout(checkReposVariable, 5000)
  } else if (event.payload.action === 'removed_from_repository') {
    const org = event.payload.organization.login
    getTeamID(org)
    // const repo = event.payload.repository.full_name
    setTimeout(checkTeamIDVariable, 1000)
  }
})

function getTeamID (org) {
  const https = require('https')

  const options = {
    hostname: (process.env.GHE_HOST),
    port: 443
    path: '/api/v3/orgs/' + org + '/teams',
    method: 'GET',
    headers: {
      Authorization: 'token ' + (process.env.GHE_TOKEN),
      'Content-Type': 'application/json'
    }
  }
  let body = []
  const req = https.request(options, (res) => {
    res.on('data', (chunk) => {
      body.push(chunk)
    }).on('end', () => {
      body = JSON.parse(Buffer.concat(body))
      body.forEach(item => {
        if (item.name === teamName) {
          teamId = item.id
        }
      })
    })
  })

  req.on('error, (error) => {
    console.error(error)
  })

  req.end()
}

function checkTeamIDVariable (repo) {
  if (typeof teamId != 'undefined') {
    addTeamToRepo(repo, teamId)
  }
}

function checkReposVariable (org) {
  if (typeof orgRepos !== 'undefined') {
  //      for(var repo of orgRepos) {
  //        addTeamToRepo(repo, teamId)
  // }
    reCreateTeam(org)
  }
}

function addTeamToRepo (repo, teamId) {
  const https = require('https')
  const data = JSON.stringify({
    permission: teamAccess
  })

  const options = {
    hostname: (process.env.GHE_HOST),
    port: 443,
    path: '/api/v3/teams/' + teamId + '/repos/' + repo,
    method: 'PUT',
    headers: {
      Authorization: 'token ' + (process.env.GHE_TOKEN),
      'Content-Type': 'application/json',
      'Content-Length': data.length
    }
  }
  let body = []

  const req = https.request(options, (res) => {
    res.on('data', (chunk) => {

      body.push(chunk)

    }).on('end', () => {

      body = Buffer.concat(body).toString()
      console.log(res.statusCode)
      console.log('added team to ' + repo)
    })
  })

  req.on('error', (error) => {
    console.error(error)
  })

  req.write(data)
  req.end()
}

function reCreateTeam (org) {
  const https = require('https')
  const data = JSON.stringify({
    name: teamName,
    description: teamDescription,
    privacy: teamPrivacy
    maintainers: userArray,
    repo_names: orgRepos
  })

  const options = {
    hostname: (process.env.GHE_HOST),
    port: 443
    path: '/api/v3/orgs/' + org + '/teams',
    method: 'POST',
    headers: {
      Authorization: 'token ' + (process.env.GHE_TOKEN),
      'Content-Type': 'application/json',
      'Content-Length': data.length
    }
  }
  // const body = []
  const req = https.request(options, (res) => {
    if (res.statusCode !== 201) {
      console.log('Status code: ' + res.statusCode)
      console.log('Added ' + teamName + ' to ' + org + ' Failed')
      res.on('data', function (chunk) {
        console.log('BODY: ' + chunk)
      })
    } else {
      console.log('Added ' + teamName ' to ' + org)
    }
  })

  req.on('error', (error) => {
    console.error(error)
  })

  req.write(data)
  req.end()
}

function getRepositories (org) {
  orgRepos = []

  const https = require('https')

  const options = {
    hostname: (process.env.GHE_HOST),
    port: '443',
    path: '/api/v3/orgs/' + org + "/repos",
    method: 'GET',
    headers: {
      Authorization: 'token ' + (process.env.GHE_TOKEN),
      'Content-Type': 'application/json'
    }
  }
  let body = []
  const req = https.request(options, (res) => {
    res.on('data', (chunk) => {
      body.push(chunk)

    }).on('end', () => {
      body = JSON.parse(Buffer.concat(body))
      body.forEach(item => {
        orgRepos.push(item.full_name)

        console.log(item.full_name)
      })
    })
  })

  req.on('error', (error) => {
    console.error(error)
  })
  req.end()
}
